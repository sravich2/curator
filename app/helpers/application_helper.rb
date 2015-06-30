require 'feedlr'
require 'json'
module ApplicationHelper
  def categories
    client = Feedlr::Client.new(oauth_access_token: ENV["OAUTH_TOKEN"])
    JSON.pretty_generate(client.stream_entries_contents('feed/http://feeds.howstuffworks.com/DailyStuff', count: 2))
  end
end
