class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :subscriptions, foreign_key: :subscriber_id
  has_many :subscribed_users, through: :subscriptions, source: :poster
  has_many :users_that_subscribed, through: :subscriptions, source: :subscriber

  has_one_attached :profile_picture

  has_rich_text :bio

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :comment_likes, dependent: :destroy
  has_many :liked_comments, through: :comment_likes, source: :comment

  def admin?
    admin
  end

end
