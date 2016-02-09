class Subtask < ActiveRecord::Base
    belongs_to :task
    validates :task_id, presence: true
end
