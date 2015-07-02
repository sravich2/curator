module OpenCalaisClient
  class << self
    def client
      @client ||= OpenCalais::Client.new
    end
  end
end