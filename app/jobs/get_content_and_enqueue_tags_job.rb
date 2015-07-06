require 'open-uri'

class GetContentAndEnqueueTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    current_article = Article.where(:id => args.at(0)).first
    source = open(current_article.url).read
    content = Readability::Document.new(source, :tags => %w[div p]).content
    content = ActionView::Base.full_sanitizer.sanitize(content)
    current_article.content = content
    current_article.save

    GetTagsJob.perform_later(current_article.id)

  end

end
