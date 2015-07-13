class AddIconUrlsToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :favicon_url, :string
    add_column :feeds, :logo_url, :string

  end
end
