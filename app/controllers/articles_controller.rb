class ArticlesController < ApplicationController
  def index
    @articles = User.first.feeds.all.collect { |feed| feed.articles.all }.flatten! #TODO: Change User.first to User.current_user
  end
end
