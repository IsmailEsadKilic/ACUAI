class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy pin unpin ]
  # before_action :authenticate_user!, only: %i[ new create edit update destroy pin unpin ]
  before_action :authenticate_user!, except: %i[ index show pinned announcements ]
  before_action :authorize_user!, only: %i[ edit update destroy ]
  before_action :check_admin!, only: %i[ pin unpin ]

  # if you want only logged in users to be able to create a new post
  # before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /posts or /posts.json

  def index
    @posts = Post.all

    if params[:search].present? && params[:topic_id].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:search]}%").where(topic_id: params[:topic_id])
    elsif params[:search].present?
      @posts = @posts.where("title LIKE ?", "%#{params[:search]}%")
    elsif params[:topic_id].present?
      @posts = Topic.find(params[:topic_id]).posts
    end

    case params[:order]
    when "pinned"
      @posts = @posts.order(pinned: :desc, created_at: :desc)
    when "new"
      @posts = @posts.order(created_at: :desc)
    when "old"
      @posts = @posts.order(created_at: :asc)
    else
      @posts = @posts.order(created_at: :desc)
    end
  end


  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])

    current = @post.views ? @post.views : 0
    @post.update(views: current + 1)

    @comment = Comment.new
    @comments = @post.comments.order(created_at: :desc)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.build(post_params)

    unless current_user.admin?
      @post.pinned = false
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update

    unless current_user.admin?
      post_params.delete(:pinned)
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path, status: :see_other, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def pin
    @post.update(pinned: true)
    redirect_to @post, notice: "Post was successfully pinned."
  end

  def unpin
    @post.update(pinned: false)
    redirect_to @post, notice: "Post was successfully unpinned."
  end

  def pinned
    @posts = Post.pinned.order(created_at: :desc)
  end

  def announcements
    @posts = Post.announcement.order(created_at: :desc)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Check if the current user is the owner of the post
  def authorize_user!
    unless current_user == @post.user || current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to post_path(@post)
    end
  end

  # Check if the current user is an admin
  # This is a simple way to check if a user is an admin
  # You can implement a more complex authorization system
  def check_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to post_path(@post)
    end
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :pinned, :announcement, :topic_id, uploads: [])
  end
  end
