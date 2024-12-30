class UploadedFile < ApplicationRecord
  has_one_attached :file

  validates :name, presence: true
  validates :file, presence: true
  validate :correct_mime_type

  private

  def correct_mime_type
    if file.attached? && !file.content_type.in?(%w[image/png image/jpg image/jpeg application/pdf])
      errors.add(:file, 'must be a PNG, JPG, JPEG, or PDF file')
    end
  end
end