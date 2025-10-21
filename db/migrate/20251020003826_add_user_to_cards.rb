class AddUserToCards < ActiveRecord::Migration[8.0]
  def change
    add_column :cards, :user_id, :integer
    add_foreign_key :cards, :users
  end
end
