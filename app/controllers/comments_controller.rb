require 'pry'

class CommentsController < ApplicationController

  def create
    #raise params.inspect
    comment = Comment.create(comment_params)
    redirect_to post_path(comment.post)
  end

  def users_attributes=(user_hash)
    raise user_hash.inspect
    if user_hash['username'].present?
      user=User.find_or_create_by(username:user_hash[:username])
      self.user_id=user.id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :users_attributes=>[:username])
  end
end
