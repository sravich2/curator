require 'open-uri'

class GetContentAndTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    current_article = Article.where(:id => args.at(0)).first
    source = open(current_article.url).read
    content = Readability::Document.new(source, :tags => %w[div p]).content
    content = ActionView::Base.full_sanitizer.sanitize(content)
    current_article.content = content

    open_calais_response = OpenCalaisClient.client.enrich(content)
    current_article.tags = open_calais_response.tags
    current_article.topics = open_calais_response.topics
    current_article.save
  end
end
