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
    html_content = open(self.readability_url).read
    html_doc = Nokogiri::HTML(html_content)
    complete_content_html = html_doc.search('//article').first.to_html
    complete_content_html_doc = Nokogiri::HTML(complete_content_html)
    header_html = html_doc.search('//header').first.to_html
    content_html_doc = complete_content_html_doc.search('//section').first
    content_html_doc.search('//ul').each do |node|
      node.remove
    end
    content_html_doc.to_html
  end


end
