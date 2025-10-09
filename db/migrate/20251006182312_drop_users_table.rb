class DropUsersTable < ActiveRecord::Migration[8.0]
  def up
    drop_table :users
  end
end
