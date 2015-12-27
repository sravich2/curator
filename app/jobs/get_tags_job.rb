class GetTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)

    current_article = Article.find(args.at(0))
    title = current_article.title
    content = current_article.content
<<<<<<< HEAD
    open_calais_response = OpenCalaisClient.client.enrich(title + content)
    puts "#{open_calais_response.relations}"
    current_article.tags = single_score_hash(open_calais_response.tags)
    current_article.locations = single_score_hash(open_calais_response.locations)
    current_article.topics = single_score_hash(open_calais_response.topics)
    current_article.entities = entity_data_to_hash(open_calais_response.entities)

    add_data_to_all_tags(current_article)

    # current_article.relations = relations_data_to_hash(open_calais_response.relations)
    current_article.save
  end

  private

  def add_data_to_all_tags(current_article)
    current_user = User.first
    attrs = Article.prediction_fields
    attrs.each do |attr|
      if Article.array_fields.include?(attr)
        current_article.most_likely(attr).each do |a| # TODO: Fix the most_likely with author (it won't work)
          current_user.all_tags[attr][a] = (current_user.all_tags[attr][a] || 0) + 1
        end
      else
        attr_value = current_article.public_send(attr.to_sym)
        current_user.all_tags[attr][attr_value] = (current_user.all_tags[attr][attr_value] || 0) + 1
      end
    end
    current_user.save
  end

  def single_score_hash(hash_array)
    score_hash = Hash.new
    hash_array.each do |hash|
      score_hash[hash[:name]] = hash[:score]
    end
    score_hash
  end

  def entity_data_to_hash(hash_array)
    entities = Hash.new
    hash_array.each do |entity_info|
      name = entity_info[:name]
      type = entity_info[:type]
      score = entity_info[:score]
      if entities[type].nil?
        entities[type] = Hash(name => score)
      else
        entities[type][name] = score
      end
    end
    entities
  end

  def relations_data_to_hash(relations_data)
    relations_data.select { |k, v| k!='forenduserdisplay' }
  end
end

