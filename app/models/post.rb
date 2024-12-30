class Post < ApplicationRecord
  belongs_to :user
  belongs_to :topic, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_rich_text :body
  has_many_attached :uploads

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true
  validate :body_length
  validate :correct_upload_mime_type

  scope :pinned, -> { where(pinned: true) }
  scope :announcement, -> { where(announcement: true) }

  private

  def body_length
    return unless body.present?
    text_length = body.to_plain_text.length
    if text_length < 5
      errors.add(:body, 'is too short (minimum is 5 characters)')
    elsif text_length > 10000
      errors.add(:body, 'is too long (maximum is 10000 characters)')
    end
  end

  def correct_upload_mime_type
    uploads.each do |upload|
      unless upload.content_type.in?(%w[image/png image/jpg image/jpeg application/pdf])
        errors.add(:uploads, 'must be PNG, JPG, JPEG, or PDF files')
        upload.purge
      end
    end
  end
end
