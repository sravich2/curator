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
        self.articles.create(article_data)
      end
    end
  end

  def self.custom_fields
    Feed.new.attributes.keys - ["created_at", "updated_at", "id"]
  end

  private

  def parse_article(article_hash)
    article_data = Hash.new
    article_data['feedly_id'] = article_hash['id']
    article_data['title'] = article_hash['title']
    article_data['content'] = article_hash['summary']
    article_data['url'] = article_hash['originId']
    article_data
  end

end