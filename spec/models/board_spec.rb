require 'rails_helper'

RSpec.describe Board, type: :model do
  context 'タイトルが入力されている場合' do
    before do
      user = User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Faker::Lorem.characters(number: 10),
      )
      @board = user.boards.build(
        name: Faker::Lorem.characters(number: 10),
        description: Faker::Lorem.characters(number: 300)
      )
    end

    it "ボードを保存できる" do
      expect(@board).to be_valid
    end
  end
end
