class CreateDeckTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :deck_topics do |t|
      t.references :deck
      t.references :topic

      t.timestamps
    end
  end
end
