class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :oauth_token

      t.text :all_tags
      t.text :liked_tags
      t.timestamps null: false
    end
  end
end
