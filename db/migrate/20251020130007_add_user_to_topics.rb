class AddUserToTopics < ActiveRecord::Migration[8.0]
  def change
    add_column :topics, :user_id, :integer
    add_foreign_key :topics, :users
  end
end
