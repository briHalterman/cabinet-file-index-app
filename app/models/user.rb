class User < ApplicationRecord
  has_secure_password

  has_many :topics, dependent: :destroy
  has_many :decks, dependent: :destroy
  has_many :cards, dependent: :destroy

  validates :role, presence: true
  validates :role, inclusion: { in: [ "admin", "user" ] }
end
