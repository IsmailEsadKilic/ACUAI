class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :comment
  has_many :notifications, as: :recipient, dependent: :destroy
  
  has_many :subscriptions_as_subscriber, class_name: 'Subscription', foreign_key: 'subscriber_id', dependent: :destroy
  has_many :subscriptions_as_poster, class_name: 'Subscription', foreign_key: 'poster_id', dependent: :destroy
  has_many :subscribers, through: :subscriptions_as_poster, source: :subscriber
  has_many :subscribed_to, through: :subscriptions_as_subscriber, source: :poster
  has_one_attached :profile_picture
  has_rich_text :bio

  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validate :correct_profile_picture_mime_type

  def subscriptions
    subscriptions_as_subscriber
  end

  def subscribed_users
    subscribed_to
  end

  private

  def correct_profile_picture_mime_type
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:profile_picture, 'must be a PNG, JPG, or JPEG file')
      profile_picture.purge
    end
  end
end
