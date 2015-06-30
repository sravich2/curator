class Subscription < ActiveRecord::Base
  def self.custom_fields
    Subscription.new.attributes.keys - ["created_at", "updated_at", "id"]
  end
end
