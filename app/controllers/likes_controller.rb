class LikesController < ApplicationController
  def create
    a_id = params[:article_id]
    u_id = params[:user_id]
    unless Like.where(:article_id => a_id).where(:user_id => u_id).exists?
      Like.create(:user_id => u_id, :article_id => a_id)
    end
    render :nothing => true
  end
end
