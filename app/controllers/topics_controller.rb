class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ edit update destroy ]
  before_action :authenticate_user!
  before_action :check_admin!, only: %i[ new create edit update destroy ]
  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path, notice: "Topic was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: "Topic was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy

    #set every post's topic_id to nil
    @topic.posts.each do |post|
      post.update(topic_id: nil)
    end

    @topic.destroy
    redirect_to topics_path, notice: "Topic was successfully destroyed."
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end

  def check_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to topics_path
    end
  end

  def topic_params
    params.require(:topic).permit(:name, :description)
  end
end