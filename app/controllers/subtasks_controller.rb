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
    Subtask.find(params[:id]).update_attributes(subtask_params)
    head :no_content
  end
  
  private
      
    def subtask_params
      params.require(:subtask).permit(:name, :description, :goal, :complete, :task_id)
    end
end
