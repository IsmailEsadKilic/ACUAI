class UploadedFile < ApplicationRecord
  has_one_attached :file
  validates :file, presence: true
  validate :correct_mime_type

  def correct_mime_type
    if file.attached? && !file.content_type.in?(%w[image/png image/jpg image/jpeg application/pdf])
      file.purge
      errors.add(:file, 'must be a PNG, JPG, JPEG, or PDF')
    end
  end

end