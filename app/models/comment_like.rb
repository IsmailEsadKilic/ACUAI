class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  validates :user_id, presence: true
  validates :comment_id, presence: true
  validates :user_id, uniqueness: { scope: :comment_id }
end
