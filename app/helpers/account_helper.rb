require 'open-uri'

module AccountHelper
  def sandbox
    # currentTime = Time.now
    GetContentAndTagsJob.perform_later(23)
    # GetContentAndTagsJob.perform_later
#     # Preview display of web page (DONT REMOVE THIS BLOCK)
#     Time.now - currentTime

#     # content.html.to_s.html_safe
#
#     source = Article.find(id = 5).url
#     content = Readability::Document.new(source, :tags => %w[div p]).content
# #     strip_tags(content).to_s.html_safe
#     open_calais = OpenCalais::Client.new
#     response = OpenCalaisClient.client.enrich(content)
# # #     response.raw.inspect
# #     response.topics.each{|t| puts t[:name]}
#     response.tags.at(0).class

  end
end
