class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy pin unpin ]
  before_action :authenticate_user!, only: %i[ new create edit update destroy pin unpin ]

  # if you want only logged in users to be able to create a new post
  # before_action :authenticate_user!, only: %i[ new create edit update destroy ]

  # GET /posts or /posts.json

  def index
    if params[:search].present?
      @posts = Post.where("title LIKE ?", "%#{params[:search]}%").order(created_at: :desc)
    elsif params[:topic_id].present?
      @posts = Topic.find(params[:topic_id]).posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
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
    if user_signed_in?
      "User signed in"
      @post = current_user.posts.build(post_params)
    else
      "User not signed in"
      @post = Post.new(post_params)
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
    @post.destroy!

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

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :pinned, :announcement, :topic_id, uploads: [])
  end
end
