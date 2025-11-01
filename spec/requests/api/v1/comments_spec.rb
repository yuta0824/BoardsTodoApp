require 'rails_helper'
require 'swagger_helper'

COMMENT_COLLECTION_SCHEMA = {
  type: :array,
  items: {
    type: :object,
    properties: {
      id: { type: :integer },
      content: { type: :string },
      commenterName: { type: :string },
      commenterAvatar: { type: :string },
      isOwner: { type: :boolean }
    },
    required: %w[id content commenterName commenterAvatar isOwner]
  }
}.freeze

RSpec.describe 'Comments API', type: :request do
  let!(:user) { create(:user) }
  let!(:board) { create(:board, user: user) }
  let!(:task) { create(:task, user: user, board: board) }

  path '/api/v1/boards/{board_id}/tasks/{task_id}/comments' do
    parameter name: :board_id, in: :path, type: :integer, description: 'Board ID'
    parameter name: :task_id, in: :path, type: :integer, description: 'Task ID'

    get 'コメント一覧を表示する' do
      tags 'Comments'
      produces 'application/json'

      let!(:comments) { create_list(:comment, 3, user: user, task: task) }
      let(:board_id) { board.id }
      let(:task_id) { task.id }

      before { sign_in user }

      response '200', 'コメント一覧を取得' do
        schema COMMENT_COLLECTION_SCHEMA

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body.size).to eq(comments.size)
          first_comment = body.first

          expect(first_comment.keys).to match_array(%w[id content commenterName commenterAvatar isOwner])
          expect(first_comment['commenterName']).to eq(user.name)
          expect(first_comment['commenterAvatar']).to be_a(String)
          expect(first_comment['commenterAvatar']).to be_present
          expect(first_comment['isOwner']).to eq(true)
        end
      end
    end

    post 'コメントを作成する' do
      tags 'Comments'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :comment, in: :body, required: true, schema: {
        type: :object,
        properties: {
          comment: {
            type: :object,
            properties: {
              content: { type: :string }
            },
            required: %w[content]
          }
        },
        required: %w[comment]
      }

      let(:board_id) { board.id }
      let(:task_id) { task.id }
      let(:comment) { { comment: { content: 'New comment from rswag' } } }

      before { sign_in user }

      response '200', 'コメントが作成される' do
        schema COMMENT_COLLECTION_SCHEMA

        run_test! do |_response|
          body = JSON.parse(response.body)
          created_comment = body.last

          expect(created_comment['content']).to eq('New comment from rswag')
          expect(created_comment['commenterName']).to eq(user.name)
          expect(created_comment['isOwner']).to eq(true)
          expect(created_comment['id']).to eq(Comment.last.id)
        end
      end
    end
  end

  path '/api/v1/comments/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'Comment ID'

    delete 'コメントを削除する' do
      tags 'Comments'
      produces 'application/json'

      let!(:comments) { create_list(:comment, 2, user: user, task: task) }
      let(:comment_to_delete) { comments.first }
      let(:id) { comment_to_delete.id }

      before { sign_in user }

      response '200', 'コメントが削除される' do
        schema COMMENT_COLLECTION_SCHEMA

        run_test! do |_response|
          body = JSON.parse(response.body)
          expect(Comment.exists?(comment_to_delete.id)).to be_falsey
          remaining_ids = body.map { |comment| comment['id'] }
          expect(remaining_ids).not_to include(comment_to_delete.id)
          expect(body).to all(include('isOwner' => true))
        end
      end
    end
  end
end
