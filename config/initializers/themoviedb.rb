module TMDBClient
  class << self
    def initialize
	Tmdb::Api.key("d2fd94c10e975d2fc41d565b160bdf05")
    end
  end
end
