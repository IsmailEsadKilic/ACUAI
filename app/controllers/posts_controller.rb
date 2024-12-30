class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :check_owner!, only: [:edit, :update, :destroy]
  after_action :mark_notifications_as_read, only: [:show]

  def index
    @posts = Post.includes(:user, :topic).order(created_at: :desc)
  end

  def show
    @post.increment!(:views)
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  def like
    @post.likes.create(user: current_user)
    redirect_to @post
  end

  def unlike
    @post.likes.where(user: current_user).destroy_all
    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :topic_id, :pinned, :announcement, uploads: [])
  end

  def check_owner!
    unless current_user == @post.user || current_user.admin?
      redirect_to posts_url, alert: 'You are not authorized to do that.'
    end
  end

  def mark_notifications_as_read
    return unless current_user
    notifications = @post.notifications.where(recipient: current_user).unread
    notifications.update_all(read_at: Time.current) if notifications.any?
  end
end
