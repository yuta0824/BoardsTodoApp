require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }
  let!(:task) { create(:task, user: user, board: board) }
  let!(:comments) { create_list(:comment, 3, user: user, task: task) }

  describe 'GET /api/v1/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '200 Status' do
        get api_v1_board_task_comments_path(board_id: board.id, task_id: task.id)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /api/v1/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'コメントが保存される' do
        comment_params = attributes_for(:comment)
        post api_v1_board_task_comments_path(board_id: board.id, task_id: task.id), params: {comment: comment_params}
        expect(response).to have_http_status(200)
        expect(Comment.last.content).to eq(comment_params[:content])
      end
    end
  end

  describe 'DELETE /api/v1/comments' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it 'コメントが削除される' do
        comment = comments.last
        delete api_v1_comment_path(id: comment.id)
        expect(response).to have_http_status(200)
        expect(Comment.exists?(comment.id)).to be_falsey
      end
    end
  end
end
