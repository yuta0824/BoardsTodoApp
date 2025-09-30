class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_board_and_task, only: [:new, :create]

    def new
      @comment = current_user.comments.build
    end

    def create
      @comment = current_user.comments.build(comment_params.merge(task: @task))

      if @comment.save
        redirect_to board_task_path(@board, @task), notice: 'コメントしました'
      else
        render :new, status: :unprocessable_entity
      end
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
