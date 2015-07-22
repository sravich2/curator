class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :feedly_id
      t.string :title
      t.string :author
      t.text :content
      t.string :url
      t.text :topics
      t.text :tags
      t.text :entities
      t.text :locations
      t.datetime :published

      t.belongs_to :feed
      t.timestamps null: false
    end
    add_index :articles, :feedly_id, :unique => true

  end
end
