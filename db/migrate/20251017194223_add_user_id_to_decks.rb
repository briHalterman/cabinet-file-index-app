class AddUserIdToDecks < ActiveRecord::Migration[8.0]
  def change
    add_column :decks, :user_id, :integer
    add_foreign_key :decks, :users
  end
end
