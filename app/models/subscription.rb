class Subscription < ApplicationRecord
  belongs_to :poster, class_name: 'User'
  belongs_to :subscriber, class_name: 'User'

  validates :poster, presence: true
  validates :subscriber, presence: true
end
