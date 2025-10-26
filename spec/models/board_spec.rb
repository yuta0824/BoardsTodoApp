require 'rails_helper'

RSpec.describe Board, type: :model do
  it "タイトルが入力されていれば、ボードを保存できる" do
    user = User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Lorem.characters(number: 10),
    )
    board = user.boards.build(
      name: Faker::Lorem.characters(number: 10),
      description: Faker::Lorem.characters(number: 300)
    )

    expect(board).to be_valid
  end
end
