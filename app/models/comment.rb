class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :comment_likes, dependent: :destroy
  has_many :liked_by_users, through: :comment_likes, source: :user
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_noticed_notifications model_name: 'Notification'

  validates :body, presence: true
  validate :body_length_validation

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications

  def notify_recipient
    CommentNotification.with(comment: self, post: post).deliver_later(post.user)
  end

  def cleanup_notifications
    notifications.destroy_all
  end

  private

  def body_length_validation
    return unless body.present?
    
    if body.length < 10
      errors.add(:body, 'is too short (minimum is 10 characters)')
    elsif body.length > 1000
      errors.add(:body, 'is too long (maximum is 1000 characters)')
    end
  end
end
