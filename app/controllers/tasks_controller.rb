class TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    @tasks = Task.all
  end

end
