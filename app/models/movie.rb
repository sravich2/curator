class Movie < ActiveRecord::Base

  serialize :cast, JSON
  serialize :plot_keywords, JSON
  serialize :genres, JSON

  def self.prediction_fields
    %w(plot_keywords cast director genres)
  end

  def self.array_fields
    %w(plot_keywords cast genres)
  end
end
