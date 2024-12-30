class Topic < ApplicationRecord
  has_many :posts, dependent: :nullify

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
end
