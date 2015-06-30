class Subscription < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.custom_fields
    Subscription.new.attributes.keys - ["created_at", "updated_at", "id"]
  end
end
