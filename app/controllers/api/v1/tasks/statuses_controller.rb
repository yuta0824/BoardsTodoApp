class Api::V1::Tasks::StatusesController < Api::V1::ApplicationController
  def update
    task = Task.find(params[:task_id])

    if task.pending?
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
