class BoardsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

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
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def board_params
    params.require(:board).permit(:name, :description)
  end
end
