class Api::V1::Tasks::StatusesController < ApplicationController
  before_action :authenticate_user!

  def update
    task = Task.find(params[:task_id])
    task.update!(task_params)
    render json: {status: task.status}
  end

  private

  def task_params
    params.permit(:status)
  end
end
