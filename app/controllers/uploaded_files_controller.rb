class UploadedFilesController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :check_admin!, only: %i[ new create destroy ]

  def index
    @uploaded_files = UploadedFile.all
  end

  def new
    @uploaded_file = UploadedFile.new
  end

  def create
    @uploaded_file = UploadedFile.new(uploaded_file_params)
    if @uploaded_file.save
      redirect_to @uploaded_file, notice: "File was successfully uploaded."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @uploaded_file = UploadedFile.find(params[:id])
  end

  def destroy
    print "hello"
    @uploaded_file = UploadedFile.find(params[:id])
    @uploaded_file.destroy
    redirect_to uploaded_files_path, notice: "File was successfully deleted."
  end

  private

  def check_admin!
    unless current_user.admin?
      flash[:alert] = "You are not authorized to do that."
      redirect_to root_path
    end
  end

  def uploaded_file_params
    params.require(:uploaded_file).permit(:name, :upload)
  end
end
