class TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def create
    Task.new(task_params).save
    render 'index', status: 201
  end

  def update
    Task.find(params[:id]).update_attributes(task_params)
    head :no_content
  end

  def destroy
    Task.find(params[:id]).destroy
    head :no_content
  end
  
  private
      
    def task_params
      params.require(:task).permit(:name, :description, :goal)
    end
    
end
