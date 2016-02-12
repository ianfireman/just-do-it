class SubtasksController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def show
    @subtask = Subtask.find(params[:id])
  end
  
  def create
    Subtask.new(subtask_params).save
  end

  def destroy
    Subtask.find(params[:id]).destroy
    head :no_content
  end
  
  def update
    subtask = Subtask.find(params[:id])
    if !subtask.goal.nil? && subtask.goal.to_s != params[:subtask][:goal] # fiz esse algoritmo por causa de um bug no datepicker do angular ui, ele retorna o dia com um dia a mais
      dateU = Date.parse(params[:subtask][:goal][0,10])
      params[:subtask][:goal] = (dateU - 1).to_s
    end
    subtask.update_attributes(subtask_params)
    head :no_content
  end
  
  private
      
    def subtask_params
      params.require(:subtask).permit(:name, :description, :goal, :complete, :task_id)
    end
end
