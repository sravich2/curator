desc "Deletes everything in DB and resets"
task :reset do
  User.delete_all
  Feed.delete_all
  Article.delete_all
  User.create(:oauth_token => ENV["OAUTH_TOKEN"])
  User.first.populate_feeds
end
