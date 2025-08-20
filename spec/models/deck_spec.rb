require 'rails_helper'

RSpec.describe Deck, type: :model do
  it 'returns the title for a deck' do
    deck = Deck.create(title: 'Test Deck')

    expect(deck.deck_title).to eq 'Test Deck'
  end
end
