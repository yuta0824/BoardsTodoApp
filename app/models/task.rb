# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :text
#  due_date    :date
#  name        :string           not null
#  status      :integer          default("todo"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  board_id    :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_board_id  (board_id)
#  index_tasks_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (board_id => boards.id)
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :board
  has_many :comments, dependent: :destroy
  has_one_attached :thumbnail

  enum status: { todo: 0, done: 1 }

  validates :name, presence: true

  def comments_count
    self.comments.count
  end

  def comment_users
    User.where(id: comments.select(:user_id).distinct)
  end
end
