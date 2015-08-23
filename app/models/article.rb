class Article < ActiveRecord::Base
  belongs_to :feed
  serialize :tags, Hash
  serialize :topics, Hash
  serialize :entities, Hash
  serialize :locations, Hash

  def self.custom_fields
    Article.new.attributes.keys - %w(created_at updated_at id)
  end
end
