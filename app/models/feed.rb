require 'date'

class Feed < ActiveRecord::Base
  has_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def populate_articles
    client = FeedlrClient.client
    client.stream_entries_contents(self.feedly_id).to_hash['items'].each do |article|
      unless self.articles.where(:feedly_id => article['id']).exists?
        article_data = parse_article(article)
        article_data['feed_id'] = self.id
        created_article = self.articles.create(article_data)
        GetContentAndEnqueueTagsJob.perform_later(created_article.id)
      end
    end
  end

  def self.custom_fields
    Feed.new.attributes.keys - %w(created_at updated_at id)
  end

  private

  def parse_article(article_hash)
    article_data = Hash.new
    article_data['feedly_id'] = article_hash['id']
    article_data['title'] = article_hash['title']
    article_data['author'] = article_hash['author']
    article_data['published'] = DateTime.strptime(article_hash['published'].to_s, '%Q') # Converts milliseconds since epoch to DateTime
    origin_id = article_hash['originId']
    if origin_id.include?('www.') || origin_id.include?('http')
      article_data['url'] = origin_id
    else
      article_data['url'] = article_hash['alternate'].at(0)['href']
    end
    enc_uri = CGI::escape(article_data['url'])
    article_data['readability_url'] = "http://www.readability.com/m?url=#{enc_uri}"
    article_data
  end

end