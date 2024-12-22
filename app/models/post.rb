class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }
  has_rich_text :body
  belongs_to :topic, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :uploads
  validate :correct_upload_mime_type
  scope :pinned, -> { where(pinned: true) }
  scope :announcement, -> { where(announcement: true) }

  has_many :likes, dependent: :destroy

  has_many :liked_by_users, through: :likes, source: :user

  def correct_upload_mime_type
    if uploads.attached? && uploads.any? { |upload| !upload.content_type.in?(%w[image/png image/jpg image/jpeg application/pdf]) }
      errors.add(:uploads, 'must be a PNG, JPG, JPEG, or PDF')
    end
  end
end
