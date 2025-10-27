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
end
