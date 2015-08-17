class LikesController < ApplicationController
  def create
    a_id = params[:article_id]
    u_id = params[:user_id]
    unless Like.where(:article_id => a_id).where(:user_id => u_id).exists?
      Like.create(:user_id => u_id, :article_id => a_id)
      current_article = Article.find(a_id)
      current_user = User.first

      attrs = Article.prediction_fields

      attrs.each do |attr|
        if Article.array_fields.include?(attr)
          current_article.most_likely(attr.to_sym).each do |a|
            current_user.article_likes[attr][a] = (current_user.article_likes[attr][a] || 0) + 1
          end
        else
          attr_value = current_article.public_send(attr.to_sym)
          current_user.article_likes[attr][attr_value] = (current_user.article_likes[attr][attr_value] || 0) + 1
        end
      end
      current_user.save
    end
    render :nothing => true
  end
end
