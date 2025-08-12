class CreateCardDecks < ActiveRecord::Migration[8.0]
  def change
    create_table :card_decks do |t|
      t.references :deck
      t.references :card

      t.timestamps
    end
  end
end
