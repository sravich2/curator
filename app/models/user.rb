class User < ActiveRecord::Base
  has_many :subscriptions
  has_many :feeds, through: :subscriptions

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

  private

  def parse_feed(feedlr_collection)
    feed_data = Hash.new
    feed_data['feedly_id'] = feedlr_collection['id']
    feed_data['website'] = feedlr_collection['website']
    feed_data['subscribers'] = feedlr_collection['subscribers'].to_i
    feed_data['topics'] = feedlr_collection['topics']
    feed_data['title'] = feedlr_collection['title']
    # feed_data['user_id'] = current_user_id
    # feed_data['user_id'] = 1
    feed_data
  end

end
