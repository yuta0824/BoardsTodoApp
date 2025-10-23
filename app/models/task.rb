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
  has_many :successor_dependencies, foreign_key: "predecessor_id", class_name: "TaskDependency", dependent: :destroy
  has_many :successors, through: :successor_dependencies, source: :successor
  has_many :predecessor_dependencies, foreign_key: "successor_id", class_name: "TaskDependency", dependent: :destroy
  has_many :predecessors, through: :predecessor_dependencies, source: :predecessor
  has_one_attached :thumbnail

  enum status: { todo: 0, done: 1 }

  validates :name, presence: true

  #successorsを持つ場合、既存のpredecessorのみ表示
  def selectable_predecessors
    scope = board.tasks
                 .where.not(id: id)
                 .where.not(status: :done)

    return scope unless successors.exists?

    predecessors.merge(scope)
  end

  def comments_count
    self.comments.count
  end

  def comment_users
    User.where(id: comments.select(:user_id).distinct)
  end

  def add_successor!(task)
    successor_dependencies.create!(successor_id: task.id)
  end

  def add_predecessor!(task)
    predecessor_dependencies.create!(predecessor_id: task.id)
  end

  def remove_successor!(task)
    successor_dependencies.find_by!(successor_id: task.id).destroy!
  end

  def remove_predecessor!(task)
    predecessor_dependencies.find_by!(predecessor_id: task.id).destroy!
  end

  def has_predecessors_todo?
    if predecessors.loaded?
      predecessors.any?(&:todo?)
    else
      predecessors.where(status: :todo).exists?
    end
  end

  def has_successors_todo?
    if successors.loaded?
      successors.any?(&:todo?)
    else
      successors.where(status: :todo).exists?
    end
  end

  def display_status
    return 'pending' if has_predecessors_todo?
    status
  end

  def predecessor?
    successor_dependencies.exists?
  end
end
