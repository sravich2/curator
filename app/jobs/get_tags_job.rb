class GetTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    current_article = Article.find(args.at(0))
    content = current_article.content
    open_calais_response = OpenCalaisClient.client.enrich(content)
    current_article.tags = single_score_hash(open_calais_response.tags)
    current_article.topics = single_score_hash(open_calais_response.topics)
    current_article.save
  end

  def single_score_hash(hash_array)
    score_hash = Hash.new
    hash_array.each do |hash|
      score_hash[ hash[:name] ] = hash[:score]
    end
    score_hash
  end

end
