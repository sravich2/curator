class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :website
      t.integer :subscribers
      t.string :subscription_id
      t.string :topics, array: true

      t.timestamps null: false
    end
  end
end
