class Api::V1::CommentsController < Api::V1::ApplicationController
  before_action :set_board_and_task, only: [:index, :create]

  def index
    render_comments(@task)
  end

  def create
    comment = current_user.comments.build(comment_params.merge(task: @task))
    comment.save!
    render_comments(@task)
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    task = comment.task
    comment.destroy!
    render_comments(task)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_board_and_task
    @board = Board.find(params[:board_id])
    @task = @board.tasks.find(params[:task_id])
  end

  def render_comments(task)
    comments = task.comments.includes(:user).order(created_at: :asc)
    render json: comments
  end
end
