class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :users_that_like, through: :likes, foreign_key: 'user_id', class_name: 'User'

  has_many :likes
  has_many :likers, through: :likes, source: :user

  serialize :tags, Hash
  serialize :topics, Hash
  serialize :entities, JSON
  serialize :locations, Hash


  def self.custom_fields
    Article.new.attributes.keys - %w(created_at updated_at id)
  end

end
