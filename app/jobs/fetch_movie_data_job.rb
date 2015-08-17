class FetchMovieDataJob < ActiveJob::Base
  queue_as :default

  def perform(query, year)
    TMDBClient.initialize
    movie_id = Tmdb::Search.movie(query, {:primary_release_year => year}).results.first.id rescue nil
    return nil if movie_id.nil?
    movie_data_hash = Tmdb::Movie.detail(movie_id, append_to_response: 'keywords,credits').to_h
    movie_info = movie_data_hash.slice(:title, :popularity, :vote_average, :vote_count, :overview)
    movie_info[:tmdb_id] = movie_data_hash[:id]
    movie_info[:release_date] = Date.parse(movie_data_hash[:release_date])
    movie_info[:cast] = movie_data_hash[:credits][:cast].collect { |c| c.name }
    movie_info[:director] = movie_data_hash[:credits][:crew].detect { |c| c.job == 'Director'}.name
    movie_info[:genres] = movie_data_hash[:genres].collect { |g| g.name }
    movie_info[:plot_keywords] = movie_data_hash[:keywords].keywords.collect { |k| k.name }
    # add_data_to_movie_fields({'plot_keywords' => movie_info[:plot_keywords], 'cast' => movie_info[:cast], 'director' => movie_info[:director]})
    movie_info
  end

end
