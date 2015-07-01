require 'open-uri'


module AccountHelper
  def sandbox
    open_calais = OpenCalais::Client.new
    response = open_calais.enrich('Ruby on Rails is a fantastic web framework. It uses MVC, and the Ruby programming language invented by Matz in Japan.')

# which has the 'raw' response
    response.raw

# and has been parsed a bit to get :language, :topics, :tags, :entities, :relations, :locations
# as lists of hashes
    response.tags.each{|t| puts t[:name] }
    # source = open('http://www.theverge.com/2015/7/1/8875969/microsoft-surface-pro-3-128gb-i7-processor').read
    # content = Readability::Document.new(source).content
    # sanitize(content, :tags => [])
  end
end
