desc "Fetches new articles through RSS"
namespace :articles do
  task :fetch do
    Feed.all.populate_articles
  end
end