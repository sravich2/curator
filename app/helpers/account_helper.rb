module AccountHelper
  def sandbox
    client = OpenCalaisClient.client
    entities = Hash.new
    client.enrich(Article.all[3].content).entities.each do |entity_info|
      name = entity_info[:name]
      type = entity_info[:type]
      score = entity_info[:score]
      if entities[type].nil?
        entities[type] = Hash(name => score)
      else
        entities[type][name] = score
      end
    end
    y = entities.to_yaml
    YAML::load(y)
  end
end