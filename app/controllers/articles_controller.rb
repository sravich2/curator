require 'open-uri'

class ArticlesController < ApplicationController
  def index
    @articles = User.first.feeds.all.collect { |feed| feed.articles.all }.flatten! #TODO: Change User.first to User.current_user
  end

  def show
    @article = Article.find(params[:id])
    @html = @article.generate_readable_html
  end
end
