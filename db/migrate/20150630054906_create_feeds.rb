class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :website
      t.integer :subscribers
      t.string :feedly_id
      t.string :topics, array: true

      t.timestamps null: false
    end
  end
end
