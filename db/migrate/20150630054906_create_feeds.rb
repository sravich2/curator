class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :website
      t.integer :subscribers
      t.string :feedly_id
      t.string :topics, array: true
      t.string :title

      t.timestamps null: false
    end
    add_index :feeds, :feedly_id, :unique => true
  end
end
