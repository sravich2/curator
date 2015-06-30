class Feed < ActiveRecord::Base
  has_many :articles
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def self.custom_fields
    Feed.new.attributes.keys - ["created_at", "updated_at", "id"]
  end
end
