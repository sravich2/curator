require 'open-uri'

module AccountHelper
  def sandbox
    # Article.all.each do |a|
    #   GetContentAndTagsJob.perform_later(129)
      # end
    # GetContentAndTagsJob.perform_later
#     # Preview display of web page (DONT REMOVE THIS BLOCK)

    Article.all.each do |a|
      GetContentAndTagsJob.perform_later(a.id)
    end

    # hash.each do |k,v|
    #   puts "#{k}: #{v}"
    # end
#     # content.html.to_s.html_safe
#
#     source = Article.find(id = 125).url
#     content = Readability::Document.new(source, :tags => %w[div p]).content
# # #     strip_tags(content).to_s.html_safe
#     open_calais = OpenCalais::Client.new
#     response = OpenCalaisClient.client.enrich(content)
# # # #     response.raw.inspect
# #     response.topics.each{|t| puts t[:name]}
#     response.tags.at(0)[:name]

  end
end
