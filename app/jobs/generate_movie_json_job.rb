class GenerateMovieJsonJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    movie_data = []
    f = File.open('lib/top250')
    f.each_line do |l|
      matches = /([^\(]+)\((\d{4})/.match(l)
      movie_name = matches[1].strip
      year = matches[2].to_i
      tmdb_data = FetchMovieDataJob.perform_now(movie_name, year)
      unless tmdb_data.nil?
        Movie.create(tmdb_data) # remove this line later
        movie_data << tmdb_data
      end
    end
    File.write('lib/top250.json', movie_data.to_json)
  end
end
