desc "Deletes everything in DB and resets"
task :reset do
  Rake::Task['db:drop'].invoke
  Rake::Task['db:create'].invoke
  Rake::Task['db:migrate'].invoke
  User.create(:oauth_token => ENV["OAUTH_TOKEN"])
  User.first.populate_feeds
end
