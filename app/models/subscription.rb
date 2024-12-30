class Subscription < ApplicationRecord
  belongs_to :subscriber, class_name: 'User'
  belongs_to :poster, class_name: 'User'

  validates :subscriber_id, presence: true
  validates :poster_id, presence: true
  validates :subscriber_id, uniqueness: { scope: :poster_id }
  validate :cannot_subscribe_to_self

  private

  def cannot_subscribe_to_self
    if subscriber_id == poster_id
      errors.add(:subscriber_id, "can't subscribe to yourself")
    end
  end
end
