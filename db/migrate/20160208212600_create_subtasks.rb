class CreateSubtasks < ActiveRecord::Migration
  def change
    create_table :subtasks do |t|
      t.string :name
      t.text :description
      t.date :goal
      t.boolean :complete

      t.timestamps null: false
    end
  end
end
