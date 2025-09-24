class Topic < ApplicationRecord
  has_many :deck_topics
  has_many :decks, through: :deck_topics

  belongs_to :category
end
