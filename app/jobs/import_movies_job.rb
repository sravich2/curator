class ImportMoviesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    movie_fields = User.first.movie_fields
    movie_data_json = File.read('lib/top250.json')
    movie_data_array = JSON.parse(movie_data_json)
    movie_data_array.each do |m|
      Movie.create(m)
      Movie.prediction_fields.each do |f|
        if Movie.array_fields.include?(f)
          m[f].each do |item|
            movie_fields[f][item] = (movie_fields[f][item] || 0) + 1
          end
        else
          item = m[f]
          movie_fields[f][item] = (movie_fields[f][item] || 0) + 1
        end
      end
    end
    user = User.first
    user.movie_fields = movie_fields
    user.save
  end
end
