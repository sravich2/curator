require 'open-uri'


module AccountHelper
  def sandbox

    source = open('http://www.theverge.com/2015/6/30/8870415/spaceX-explosion-NASA-America-space-future').read

    # Preview display of web page (DONT REMOVE THIS BLOCK)
    # content = Readability::Document.new(source)
    # content.prepare_candidates
    # content.html.to_s.html_safe

    content = Readability::Document.new(source, :tags => %w[div p]).content
    strip_tags(content).to_s.html_safe
#     open_calais = OpenCalais::Client.new
#
#     response = open_calais.enrich(content)
#
# # which has the 'raw' response
# #     response.raw
#
# # and has been parsed a bit to get :language, :topics, :tags, :entities, :relations, :locations
# # as lists of hashes
# #     response.topics.each{|t| puts t[:name]}
#     response.tags.inspect

  end
end
