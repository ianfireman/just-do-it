class TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index
    if params[:keywords] == 'completed'
      @tasks = Task.where(complete: true)
    elsif params[:keywords] == 'dia'
      @tasks = Task.where(complete: false, goal: Time.current.to_date)
    elsif params[:keywords] == 'semana'
      @tasks = Task.where(complete: false, goal: (Time.current.to_date...date_of_next("Monday")))
    elsif params[:keywords] == 'mes'
      @tasks = Task.where(complete: false, goal: (Time.current.to_date...Date.current.end_of_month()))
    elsif params[:keywords] == 'apos'
      @tasks = Task.where(['goal > ?', 30.days.from_now])  
      @tasks.each_with_index do |x, i|
        if x.complete == true
          @tasks[i].delete()
        end
      end
    else
      @tasks = Task.where(complete: false)
    end
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
    
    def date_of_next(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date + delta
    end
    
end
