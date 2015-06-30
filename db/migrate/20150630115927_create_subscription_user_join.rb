class CreateSubscriptionUserJoin < ActiveRecord::Migration
  def change
    create_table :subscriptions_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :subscription, index:true
    end
  end
end
