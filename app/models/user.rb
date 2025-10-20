class User < ApplicationRecord
  has_secure_password

  has_many :topics
  has_many :decks
  has_many :cards

  validates :role, presence: true
  validates :role, inclusion: { in: [ "admin", "user" ] }
end
