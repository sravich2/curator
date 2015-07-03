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
    current_article.tags = single_score_hash(open_calais_response.tags)
    current_article.topics = single_score_hash(open_calais_response.topics)
    current_article.save
  end

  def single_score_hash(hash_array)
    score_hash = Hash.new
    hash_array.each do |hash|
      hash.each do |k, v|
        score_hash[k] = v
      end
    end
    score_hash
  end

end
