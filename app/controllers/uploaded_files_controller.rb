class UploadedFilesController < ApplicationController

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

  private

  def uploaded_file_params
    params.require(:uploaded_file).permit(:name, :upload)
  end
end
