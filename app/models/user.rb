class User < ActiveRecord::Base
  has_many :subscriptions

  def self.custom_fields
    User.new.attributes.keys - ["created_at", "updated_at", "id"]
  end
end
