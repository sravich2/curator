class ImportMoviesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    movie_data_json = File.read('lib/top250.json')
    movie_data_array = JSON.parse(movie_data_json)
    movie_data_array.each { |m| Movie.create(m) }
  end
end
