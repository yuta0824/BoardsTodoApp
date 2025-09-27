class TasksController < ApplicationController
    before_action :authenticate_user!, except: [:show]

    def new
        @board = Board.find(params[:board_id])
        @task = current_user.tasks.build
    end

    def create
        @board = Board.find(params[:board_id])
        @task = current_user.tasks.build(task_params.merge(board: @board))

        if @task.save
            redirect_to board_task_path(@board.id, @task.id), notice: 'タスクが作成されました'
        else
            render :new, status: :unprocessable_entity
        end
    end

    def show
        @board = Board.find(params[:board_id])
        @task = @board.tasks.find(params[:id])
    end

    def edit
        @task = current_user.tasks.find(params[:id])
        @board = @task.board
    end

    def update
        @task = current_user.tasks.find(params[:id])
        @board = @task.board

        if @task.update(task_params)
            redirect_to board_task_path(@board.id, @task.id), notice: 'タスクが更新されました'
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @task = current_user.tasks.find(params[:id])
        @board = @task.board
        @task.destroy!
        flash[:success] = '削除しました。'
        redirect_to board_path(@board.id)
    end

    private

    def task_params
        params.require(:task).permit(:name, :description, :due_date, :thumbnail)
    end

end
