class Topic < ApplicationRecord
  has_many :deck_topics, dependent: :destroy
  has_many :decks, through: :deck_topics

  belongs_to :category

  belongs_to :user
end
