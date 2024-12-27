class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[ destroy ]

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

  def like
    #for some goddamn reason, :post_id is the comment id, and the :id is the post id
    #raise "liking comment with id#{params[:post_id]} on post with id#{params[:id]}, current_user: #{current_user.inspect}"
    @like_this_comment = Comment.find(params[:post_id])
    #raise "comment.inspect: #{@like_this_comment.inspect}"
    current_user.comment_likes.create(comment: @like_this_comment)
    redirect_to @like_this_comment.post, notice: "You liked a comment."
  end

  def unlike

    @unlike_this_comment = Comment.find(params[:post_id])
    current_user.comment_likes.find_by(comment: @unlike_this_comment).destroy
    redirect_to @unlike_this_comment.post, notice: "You unliked a comment."
  end

  private

  def authorize_user!
    @post = Post.find(params[:post_id])
    unless current_user == @post.user || current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to post_path(@post)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
