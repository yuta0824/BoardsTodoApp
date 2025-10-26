require 'rails_helper'

RSpec.describe Board, type: :model do
  let!(:user) { create(:user) }

  context 'タイトルが入力されている場合' do
    let!(:board) { build(:board, user: user) }

    it 'ボードを保存できる' do
      expect(board).to be_valid
    end
  end

  context 'タイトルが入力されていない場合' do
    let!(:board) { build(:board, name: '', user: user) }

    it 'ボードを保存できない' do
      expect(board).not_to be_valid
      expect(board.errors.details[:name]).to include({ error: :blank })
    end
  end
end
