class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ profile edit update destroy subscribe unsubscribe ]
  before_action :check_admin!, only: %i[ edit update destroy ]
  def profile
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_profile_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy!
    redirect_to root_path, notice: "User was successfully destroyed."
  end

  def subscribe
    current_user.subscriptions.create(subscriber_id: current_user.id, poster_id: @user.id)
    redirect_to profile_user_path, notice: "You are now subscribed to this user."
  end

  def unsubscribe
    current_user.subscriptions.find_by(poster_id: @user.id).destroy
    redirect_to profile_user_path, notice: "You are no longer subscribed to this user."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_picture, :bio)
  end
end
