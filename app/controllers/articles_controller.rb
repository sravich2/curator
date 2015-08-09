require 'open-uri'

class ArticlesController < ApplicationController
  def index
    @articles = User.first.feeds.all.collect { |feed| feed.articles.all }.flatten!.sort_by do |a|
      article_like_probs = a.calculate_like_probability
      -(2*article_like_probs['topics'] + 3*article_like_probs['tags'] + 4*article_like_probs['entities'])
    end #TODO: Change User.first to User.current_user
  end

  def show
    @article = Article.find(params[:id])
    @html = @article.generate_readable_html
  end
end
