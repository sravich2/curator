class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :feedly_id
      t.string :title
      t.text :content
      t.string :url
      t.text :topics
      t.text :tags

      t.belongs_to :feed
      t.timestamps null: false
    end
  end
end
