class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment was created successfully."
      # if @post.user != current_user
      #   # Send an email to the post owner when a comment is created that is not created by the post owner
      #   CommentMailer.with(comment: @comment).new_comment_email.deliver_later
      # end
      redirect_to post_path(@post)
    else
      flash[:alert] = "Comment was not saved. Please fix the errors."
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    if @comment.user == current_user
      @comment.destroy
      flash[:notice] = "Comment was deleted successfully."
    else
      flash[:alert] = "You cannot delete this comment."
    end

    redirect_to post_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
