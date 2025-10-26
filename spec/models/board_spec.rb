require 'rails_helper'

RSpec.describe Board, type: :model do
  let!(:user) { create(:user, email: "test@test.com") }

  context 'タイトルが入力されている場合' do
    let!(:board) do
      user.boards.build(
        name: Faker::Lorem.characters(number: 10),
        description: Faker::Lorem.characters(number: 300)
      )
    end

    it "ボードを保存できる" do
      expect(board).to be_valid
    end
  end

  context 'タイトルが入力されていない場合' do
    let!(:board) do
      user.boards.create(
        name: "",
        description: Faker::Lorem.characters(number: 300)
      )
    end

    it "ボードを保存できない" do
      expect(board).not_to be_valid
      expect(board.errors.details[:name]).to include({ error: :blank })
    end
  end
end
