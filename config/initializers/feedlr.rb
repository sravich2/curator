module FeedlrClient
  class << self
    def client(oauth_token = ENV["OAUTH_TOKEN"])
      @client ||= Feedlr::Client.new(:oauth_access_token => oauth_token)
    end
  end
end
