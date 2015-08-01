require 'open-uri'

class Article < ActiveRecord::Base
  belongs_to :feed
  has_many :users_that_like, through: :likes, foreign_key: 'user_id', class_name: 'User'

  has_many :likes
  has_many :likers, through: :likes, source: :user

  serialize :tags, Hash
  serialize :topics, Hash
  serialize :entities, JSON
  serialize :locations, Hash
  serialize :relations, JSON

  def self.custom_fields
    Article.new.attributes.keys - %w(created_at updated_at id)
  end

  def most_likely(field)
    case field.to_sym
      when :tags
        tags.select { |_, score| score == 0.9 }.keys
      when :topics
        topics.select { |_, score| score > 0.75 }.keys
      when :locations
        locations.select { |_, score| score >= 0.8 }.keys
      when :entities
        entities_array = Array.new
        entities.try(:each) do |_, entitiesSet|
          entities_array.concat entitiesSet.select { |_, score| score >= 0.8 }.keys
        end
        entities_array
      else
        puts 'Field does not exist'
    end
  end

  def generate_readable_html
    html_content = open(readability_url).read
    matches = /<article id.*?>(.+)<\/article>/m.match(html_content)
    matches[1]
  end

end
