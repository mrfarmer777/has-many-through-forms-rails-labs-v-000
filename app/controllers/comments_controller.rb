require 'pry'

class CommentsController < ApplicationController

  def create
    #raise params.inspect
    comment = Comment.create(content:comment_params[:content],post_id:comment_params[:post_id], user_id:comment_params[:user_id])
    redirect_to post_path(comment.post)
  end

  def user_attributes=(user_hash)
    if !user_hash[:username].blank?
      raise user_hash[:username].inspect
      user=User.find_or_create_by(username:user_hash[:username])
      self.user_id=user.id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, user_attributes:[:username])
  end
end
