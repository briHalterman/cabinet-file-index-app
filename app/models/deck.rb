class Deck < ApplicationRecord
  has_many :card_decks
  has_many :cards, through :card_decks

  has_many :deck_topics
  has_many :topics, through :deck_topics
end
