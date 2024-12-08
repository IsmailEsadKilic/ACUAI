class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }
end
