class Article < ActiveRecord::Base
  belongs_to :feed
  def self.custom_fields
    Article.new.attributes.keys - ["created_at", "updated_at", "id"]
  end
end
