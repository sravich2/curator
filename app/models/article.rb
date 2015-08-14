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

  def calculate_like_probability

    # P (L|t1, t2 .. tk) = P(t1|L) P(t2|L) .. P (tk|L) * P(L) / P(t1,t2 .. tk)
    current_user = User.first
    user_like_prob = Like.count.to_f / Article.count
    user_likes = Like.count.to_f
    probs = {}
    attrs = ['tags', 'topics', 'entities'] # Fix author with most_likely
    attrs.each do |attr|
      article_like_score = 1.to_f
      article_dislike_score = 1.to_f
      familiar_attr_set = self.most_likely(attr.to_sym).select { |i| current_user.all_tags[attr].has_key?(i) && current_user.all_tags[attr][i] > 0 }
      at_least_one_liked = false
      familiar_attr_set.each do |a|
        attr_liked_count = current_user.liked_tags[attr][a]
        if attr_liked_count.nil?
          cond_prob = 1 / user_likes
        else
          cond_prob = attr_liked_count / user_likes
          at_least_one_liked = true
        end
        article_like_score = article_like_score*cond_prob
        article_dislike_score = article_dislike_score * (1 - cond_prob)
      end
      if familiar_attr_set.blank? || !at_least_one_liked
        article_like_score = 0
      else
        article_like_score = article_like_score * [user_like_prob, 1 - user_like_prob].max
      end
      # article_dislike_score = article_dislike_score * [user_like_prob, 1 - user_like_prob].max
      probs[attr] = article_like_score*100
    end
    probs
  end

  private

  def self.prediction_fields
    %w(tags topics entities author)
  end

  def self.array_fields
    %w(tags topics entities)
  end

end
