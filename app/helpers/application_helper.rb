require 'feedlr'
require 'json'
module ApplicationHelper
  def sandbox
    client = Feedlr::Client.new(oauth_access_token: ENV["OAUTH_TOKEN"])
    client.stream_entries_contents(client.user_subscriptions.at(0)['id']).to_hash['items'].at(1)
  end
end
