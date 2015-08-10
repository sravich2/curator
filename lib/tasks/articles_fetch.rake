desc "Fetches new articles through RSS"
namespace :articles do
  task :fetch do
    Feed.all.each { |f| f.populate_articles }
  end
end