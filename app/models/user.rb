class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :feeds, through: :subscriptions

  has_many :likes
  has_many :liked_articles, through: :likes, source: :article

  serialize :all_tags, JSON
  serialize :liked_tags, JSON

  def populate_feeds

    client = FeedlrClient.client(self.oauth_token)
    client.user_subscriptions.each do |feed|
      feed_feedly_id = feed['id']
      found_feed = Feed.where(:feedly_id => feed_feedly_id).first
      if found_feed.nil?
        feed_data = parse_feed(feed)
        self.feeds.create(feed_data)
      elsif !found_feed.users.where(:id => self.id).exists?
        Subscription.create(:user_id => self.id, :feed_id => found_feed.id)
      end
    end
  end

  def self.custom_fields
    User.new.attributes.keys - ["created_at", "updated_at", "id"]
  end

  def topic_percentages
    hash = Hash.new
    feeds.each do |f|
      f.articles.each do |a|
        a.tags.each do |k, v|
          if v.to_f > 0.8
            if hash[k].nil?
              hash[k] = 1
            else
              hash[k] += 1
            end
          end
        end
      end
    end
    hash.sort_by { |_, v| -v }[0..30].to_h
  end

  private

  def parse_feed(feedlr_collection)
    feed_data = Hash.new
    feed_data['feedly_id'] = feedlr_collection['id']
    feed_data['website'] = feedlr_collection['website']
    feed_data['subscribers'] = feedlr_collection['subscribers'].to_i
    feed_data['topics'] = feedlr_collection['topics']
    feed_data['title'] = feedlr_collection['title']
    feed_data['favicon_url'] = feedlr_collection['iconUrl']
    feed_data['logo_url'] = feedlr_collection['visualUrl']
    feed_data
  end

end
