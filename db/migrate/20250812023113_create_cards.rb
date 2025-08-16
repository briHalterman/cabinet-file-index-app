class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :title
      t.text :face_content
      t.text :back_content

      t.timestamps
    end
  end
end
