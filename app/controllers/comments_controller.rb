class CommentsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :set_board_and_task, only: [:index, :new, :create]

    def index
      comments = @task.comments.includes(:user)
      render json: comments
    end

    def new
      @comment = current_user.comments.build
    end

    def create
      @comment = current_user.comments.build(comment_params.merge(task: @task))
      @comment.save!

      render json: @comment
    end

    def destroy
      @comment = current_user.comments.find(params[:id])
      @task = @comment.task
      @board = @task.board
      @comment.destroy!
      redirect_to board_task_path(@board, @task), notice: '削除しました'
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_board_and_task
      @board = Board.find(params[:board_id])
      @task = @board.tasks.find(params[:task_id])
    end
end
