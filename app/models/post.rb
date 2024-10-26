class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }
  belongs_to :topic, optional: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :uploads
  scope :pinned, -> { where(pinned: true) }
  scope :announcement, -> { where(announcement: true) }
end
