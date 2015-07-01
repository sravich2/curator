require 'feedlr'
require 'rubygems'
require 'readability'
require 'open-uri'

module AccountHelper
  def sandbox
    source = open('http://www.theverge.com/2015/7/1/8875969/microsoft-surface-pro-3-128gb-i7-processor').read
    content = Readability::Document.new(source).content
    sanitize(content, :tags => [])
  end
end
