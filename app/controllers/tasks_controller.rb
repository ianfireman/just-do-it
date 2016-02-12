class TasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def index 
    if params[:keywords]                  # condiçoes do filtro, dependendo do parametro recebido o controller ira retornar as tasks certas
      if params[:keywords] == 'completed' # caso nao tenha condiçao para o parametro recebido sera feita uma busca pelos nomes das tasks
        @tasks = Task.where(complete: true)
      elsif params[:keywords] == 'dia'
        @tasks = Task.where(complete: false, goal: Time.current.to_date)
      elsif params[:keywords] == 'semana'
        @tasks = Task.where(complete: false, goal: (Time.current.to_date...date_of_next("Monday")))
      elsif params[:keywords] == 'mes'
        @tasks = Task.where(complete: false, goal: (Time.current.to_date...(Date.current.end_of_month() + 1)))
      elsif params[:keywords] == 'apos'
        @tasks = Task.where(['goal > ?', Date.current.end_of_month()]).to_a
        @tasks.each_with_index do |x, i|
          if x.complete == true
             @tasks.delete(@tasks[i])
          end
        end
      elsif params[:keywords] == 'late'
        @tasks = Task.where(['goal < ?', Time.current.to_date]).to_a
        @tasks.each_with_index do |x, i|
          if x.complete == true
            @tasks.delete(@tasks[i])
          end
        end  
      else
        @tasks = Task.where('name like ?',"%#{params[:keywords]}%")
      end
    else
      @tasks = Task.where(complete: false)
    end
  end
  
  def show
    @task = Task.find(params[:id])
    @subtasks = @task.subtasks.all
  end
  
  def create
    Task.new(task_params).save
    render 'index', status: 201
  end

  def update
    task = Task.find(params[:id])
    if !task.goal.nil? && task.goal.to_s != params[:task][:goal] # fiz esse algoritmo por causa de um bug no datepicker do angular ui, ele retorna o dia com um dia a mais
      dateU = Date.parse(params[:task][:goal][0,10])
      params[:task][:goal] = (dateU - 1).to_s
    end
    task.update_attributes(task_params)
    head :no_content
  end

  def destroy
    Task.find(params[:id]).destroy
    head :no_content
  end
  
  private
      
    def task_params
      params.require(:task).permit(:id, :name, :description, :goal, :complete)
    end
    
    def date_of_next(day)
      date  = Date.parse(day)
      delta = date > Date.today ? 0 : 7
      date + delta
    end
    
end
