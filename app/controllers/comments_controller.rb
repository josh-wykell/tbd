class CommentsController < ApplicationController
  # before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  # def create
  #   @link = Link.find(params[:link_id])
  #   @comment = @link.comments.build(comment_params.merge(:user => current_user))

  #   if @comment.save
  #     redirect_to @link, notice: "Comment successful."  
  #   else
  #     render new, notice: "Comment failed"
  #   end
  # end

  # def destroy
  #   @comment = Comment.find(params[:id])
  #   @comment.destroy
  #   redirect_to @link, notice: "Comment deleted"
  # end

  # private

  # def comment_params
  #   params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  # end

  # # Use callbacks to share common setup or constraints between actions.
  # def set_link
  #   @link = Link.find(params[:id])
  # end


  def create
    current_user.comments.create(comment_params)
    redirect_to :back, :notice => "Added Comment"
  end

  def destroy
    current_user.comments.destroy(params[:id])
    redirect_to :back, :notice => "Removed Comment"
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_by current_user
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :body)
  end
end