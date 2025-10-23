class Api::V1::Tasks::StatusesController < ApplicationController
  before_action :authenticate_user!

  def update
    task = Task.find(params[:task_id])

    if task.has_predecessors_todo?
      render json: { error: 'Blocked by pending predecessors' }, status: :unprocessable_entity
      return
    end

    task.update!(task_params)
    render json: { status: task.status }
  end

  private

  def task_params
    params.permit(:status)
  end
end
