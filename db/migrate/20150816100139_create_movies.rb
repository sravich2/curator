class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :tmdb_id
      t.text :genres
      t.string :overview
      t.text :cast
      t.string :director
      t.date :release_date
      t.float :popularity
      t.float :vote_average
      t.integer :vote_count
      t.text :plot_keywords

      t.timestamps null: false
    end
  end
end
