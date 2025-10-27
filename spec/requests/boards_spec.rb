require 'rails_helper'

RSpec.describe "Boards", type: :request do
  let!(:user) { create(:user) }
  let!(:boards) { create_list(:board, 3, user: user) }

  describe "GET /boards" do
    it "200ステータスが返ってくる" do
      get boards_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /boards" do
    context "ログインしている場合" do
      before do
        sign_in user
      end

      it "ボードが保存される" do
        board_params = attributes_for(:board)
        post boards_path, params: {board: board_params}
        expect(response).to have_http_status(302)
        expect(Board.last.name).to eq(board_params[:name])
        expect(Board.last.description).to eq(board_params[:description])
      end
    end
  end

  context "ログインしていない場合" do
    it "ログイン画面に遷移する" do
      board_params = attributes_for(:board)
      post boards_path, params: {board: board_params}
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
