class TasksController < ApplicationController
    before_action :set_task, only: [:show, :update, :destroy]
def index 
    @tasks = Task.all
    render json: @tasks
end

def show 
    render json: @task
end

def create 
    @task = Task.new(task_params)
    if @task.save
        render json: @task, status: :created
    else 
        render json: @task.error, status: :unprocessable_entity
    end

end

def update 
    if @task.update(task_params)
        render json: @task
    else 
        render json @task.error, status: :unprocessable_entity
    end
end

def destroy
    if @task.destroy
        head :no_content;
    end

end

  private 
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:title, :completed)
  end
end
