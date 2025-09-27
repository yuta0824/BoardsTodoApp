class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_board, only: [:edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def new
    @board = current_user.boards.build
  end

  def create
    @board = current_user.boards.build(board_params)

    if @board.save
      redirect_to board_path(@board), notice: 'ボードが作成されました'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @tasks = @board.tasks
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path(@board), notice: 'ボードが更新されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @board.destroy!
    flash[:success] = '削除しました。'
    redirect_to root_path
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end
end
