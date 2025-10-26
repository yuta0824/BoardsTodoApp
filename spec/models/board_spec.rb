require 'rails_helper'

RSpec.describe Board, type: :model do
  it "タイトルが入力されていれば、ボードを保存できる" do
    user = User.create!(
      name: "山田太郎",
      email: "yamada@gmail.com",
      password: "password123",
    )
    board = user.boards.build(
      name: "hohohoho",
      description: "ddddddddd"
    )

    expect(board).to be_valid
  end
end
