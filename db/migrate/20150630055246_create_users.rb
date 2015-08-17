class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :oauth_token

      t.text :article_fields
      t.text :article_likes
      t.text :movie_fields
      t.text :movie_likes

      t.timestamps null: false
    end
  end
end
