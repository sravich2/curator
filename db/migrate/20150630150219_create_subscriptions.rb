class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :feed, index: true
      t.string :feed_feedly_id

      t.timestamps null: false
    end
  end
end
