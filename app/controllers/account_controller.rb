class AccountController < ApplicationController

  def populate_articles #(user_id = User.current_user.id)
    client = get_client(1)
    User.find(id = 1).feeds.each do |feed|
      feed_id = feed['feed_id']
      client.stream_entries_contents(feed_id).to_hash['items'].each do |article|
        # unless feed.articles.where(:article_id => article['id']).exists?
          article_data = parse_article(article)
          article_data['feed_id'] = feed_id
          feed.articles.create(article_data)
        # end
      end
    end
  end

  helper_method :populate_articles

  def populate_feeds # (user_id = current_user_id)
    client = get_client(1)
    client.user_subscriptions.each do |feed|
      # unless User.find(id = 1).feeds.where(feed_id = feed['id']).exists?
        feed_data = parse_feed(feed)
        User.find(id = 1).feeds.create(feed_data)
      # end
    end
  end

  helper_method :populate_feeds

  private

  def parse_feed(feedlr_collection)
    feed_data = Hash.new
    feed_data['feedly_id'] = feedlr_collection['id']
    feed_data['website'] = feedlr_collection['website']
    feed_data['subscribers'] = feedlr_collection['subscribers'].to_i
    feed_data['topics'] = feedlr_collection['topics']
    # feed_data['user_id'] = current_user_id
    # feed_data['user_id'] = 1
    feed_data
  end

  def parse_article(article_hash)
    article_data = Hash.new
    article_data['feedly_id'] = article_hash['id']
    article_data['title'] = article_hash['title']
    article_data['content'] = article_hash['summary']
    article_data['url'] = article_hash['originId']
    article_data
  end
end
