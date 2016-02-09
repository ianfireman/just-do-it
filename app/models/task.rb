class Task < ActiveRecord::Base
    has_many :subtasks, dependent: :destroy
end
