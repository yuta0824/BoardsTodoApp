class TasksController < ApplicationController
    before_action :authenticate_user!, except: [:show]
    before_action :set_board, only: [:new, :create, :show]
    before_action :set_task, only: [:edit, :update, :destroy]

    def new
        @task = current_user.tasks.build
    end

    def create
        @task = current_user.tasks.build(task_params.merge(board: @board))

        if @task.save
            redirect_to board_task_path(@board.id, @task.id), notice: 'タスクが作成されました'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @task = @board.tasks.find(params[:id])
    end

    def edit
        @board = @task.board
    end

    def update
        @board = @task.board

        if @task.update(task_params)
            redirect_to board_task_path(@board.id, @task.id), notice: 'タスクが更新されました'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @board = @task.board
        @task.destroy!
        flash[:success] = '削除しました。'
        redirect_to board_path(@board.id)
    end

    private

    def task_params
        params.require(:task).permit(:name, :description, :due_date, :thumbnail)
    end

    def set_board
      @board = Board.find(params[:board_id])
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
