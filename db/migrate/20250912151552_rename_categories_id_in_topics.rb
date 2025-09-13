class RenameCategoriesIdInTopics < ActiveRecord::Migration[8.0]
  def change
    rename_column :topics, :categories_id, :category_id
  end
end
