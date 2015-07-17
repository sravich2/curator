class LikesController < ApplicationController
  def create
    Like.create(:user_id => params[:user_id], :article_id => params[:article_id])
  end
end
