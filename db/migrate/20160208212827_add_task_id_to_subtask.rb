class AddTaskIdToSubtask < ActiveRecord::Migration
  def change
    add_reference :subtasks, :task, index: true
    add_index :subtasks, [:task_id, :created_at]
  end
end
