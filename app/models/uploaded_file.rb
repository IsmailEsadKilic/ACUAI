class UploadedFile < ApplicationRecord
  has_one_attached :upload
end
