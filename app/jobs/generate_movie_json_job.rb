class GenerateMovieJsonJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    movie_data = []
    f = File.open('lib/top250')
    i = 0
    f.each_line do |l|
      # if i > 45
      matches = /([^\(]+)\((\d{4})/.match(l)
      movie_name = matches[1].strip
      year = matches[2].to_i
      tmdb_data = FetchMovieDataJob.perform_now(movie_name, year)
      Movie.create(tmdb_data) # remove this line later
      movie_data << tmdb_data
      # end
      # i = i + 1
    end
    File.write('lib/top250.json', movie_data.to_json)
  end
end
