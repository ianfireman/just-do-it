class AddDefaulToCompleteSubtask < ActiveRecord::Migration
  def change
    change_column :subtasks, :complete, :boolean, :default => false
  end
end
