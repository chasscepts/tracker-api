class TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    @tasks = Task.all.includes(:group)
    json_response(@tasks)
  end

  def create
    @task = Task.create!(task_params)
    json_response(@task, :created)
  end

  def show
    json_response(@task)
  end

  def update
    @task.update(task_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private
  
  def task_params
    params.require(:task).permit(%i[title])
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
