class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ profile edit update destroy ]
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
