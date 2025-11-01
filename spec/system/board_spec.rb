require 'rails_helper'

RSpec.describe 'Board', type: :system do
  let!(:user) { create(:user) }
  let!(:boards) { create_list(:board, 3, user: user) }

  it 'ボード一覧が表示される' do
    visit root_path

    boards.each do |board|
      expect(page).to have_selector("[data-id='#{board.id}']", text: board.name)
    end
  end
end
