class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :subscription_id
      t.string :website
      t.integer :subscribers
      t.string :subscription_id
      t.string :topics, array: true
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
