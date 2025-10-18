class User < ApplicationRecord
  has_secure_password

  has_many :decks

  validates :role, presence: true
  validates :role, inclusion: { in: [ "admin", "user" ] }
end
