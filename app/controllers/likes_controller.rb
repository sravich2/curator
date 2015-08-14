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
        if attr == 'author'
          author = current_article.author
          current_value = current_user.liked_tags[attr][author]
          if current_value.nil?
            current_user.liked_tags[attr][author] = 1
          else
            current_user.liked_tags[attr][author] = current_value + 1
          end
        else
          current_article.most_likely(attr.to_sym).each do |a|
            current_value = current_user.liked_tags[attr][a]
            if current_value.nil?
              current_user.liked_tags[attr][a] = 1
            else
              current_user.liked_tags[attr][a] = current_value + 1
            end
          end
        end
      end
      current_user.save
    end
    render :nothing => true
  end
end
