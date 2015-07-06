class AddReadabilityColumnsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :readability_url, :string
  end
end
