class GetTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    current_article = Article.find(args.at(0))
    current_user = User.first
    title = current_article.title
    content = current_article.content
    open_calais_response = OpenCalaisClient.client.enrich(title + content)
    current_article.tags = single_score_hash(open_calais_response.tags)
    current_article.locations = single_score_hash(open_calais_response.locations)
    current_article.topics = single_score_hash(open_calais_response.topics)
    current_article.entities = entity_data_to_hash(open_calais_response.entities)

    attrs = ['tags', 'topics', 'entities']
    attrs.each do |attr|
      current_article.most_likely(attr).each do |a|
        current_value = current_user.all_tags[attr][a]
        if current_value.nil?
          current_user.all_tags[attr][a] = 1
        else
          current_user.all_tags[attr][a] = current_value + 1
        end
      end
    end
    current_user.save

    # current_article.relations = relations_data_to_hash(open_calais_response.relations)
    current_article.save
  end

  private

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
