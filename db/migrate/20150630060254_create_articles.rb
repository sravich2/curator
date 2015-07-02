class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :feedly_id
      t.string :title
      t.text :content
      t.string :url
      t.string :topics, array: true
      t.string :tags, array: true

      t.belongs_to :feed
      t.timestamps null: false
    end
  end
end
