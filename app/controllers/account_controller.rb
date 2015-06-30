class AccountController < ApplicationController

  def populate_articles #(user_id = User.current_user.id)
    client = get_client(1)
    User.find(id = 1).subscriptions.each do |subscription|
      subscription_id = subscription['subscription_id']
      client.stream_entries_contents(subscription_id).to_hash['items'].each do |article|
        article_data = parse_article(article)
        article_data['subscription_id'] = subscription_id
        Article.create(article_data)
      end
    end
  end
  helper_method :populate_articles

  def populate_subscriptions # (user_id = current_user_id)
    client = get_client(1)
    client.user_subscriptions.each do |subscription|
      unless User.find(id = 1).subscriptions.where(:subscription_id => subscription['id']).exists?
        subscription_data = parse_subscription(subscription)
        User.find(id = 1).subscriptions.create(subscription_data)
      end
    end
  end
  helper_method :populate_subscriptions

  private

  def parse_subscription(feedlr_collection)
    subscription_data = Hash.new
    subscription_data['subscription_id'] = feedlr_collection['id']
    subscription_data['website'] = feedlr_collection['website']
    subscription_data['subscribers'] = feedlr_collection['subscribers'].to_i
    subscription_data['topics'] = feedlr_collection['topics']
    # subscription_data['user_id'] = current_user_id
    # subscription_data['user_id'] = 1
    subscription_data
  end

  def parse_article(article_hash)
    article_data = Hash.new
    article_data['article_id'] = article_hash['id']
    article_data['title'] = article_hash['title']
    article_data['content'] = article_hash['summary']
    article_data['url'] = article_hash['originId']
    article_data
  end
end
