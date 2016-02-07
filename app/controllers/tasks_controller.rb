class TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    @tasks = Task.where(complete: false)
  end
  
  def completed
    @tasks = Task.where(complete: true)
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
  
  def complete
    @task = Task.find(params[:id])
    !@task.complete = true ? @task.update_attributes(task_params) : @task.update_attributes(task_params)
    head :no_content
  end

  def destroy
    Task.find(params[:id]).destroy
    head :no_content
  end
  
  private
      
    def task_params
      params.require(:task).permit(:name, :description, :goal, :complete)
    end
    
end
