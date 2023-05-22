module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_task, only: %i[show update destroy]
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
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      def destroy
        return unless @task.destroy

        head :no_content
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :completed)
      end
    end
  end
end
