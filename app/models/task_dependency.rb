class TaskDependency < ApplicationRecord
  belongs_to :predecessor, class_name: 'Task'
  belongs_to :successor, class_name: 'Task'

  validates :predecessor_id, uniqueness: { scope: :successor_id }
  validate :dependent_self
  validate :prevent_circular_dependency

  private

  def dependent_self
    if predecessor_id == successor_id
      errors.add(:base, "タスクは自分自身に依存できません")
    end
  end

  def prevent_circular_dependency
    if TaskDependency.exists?(predecessor_id: successor_id)
      errors.add(:base, "タスクは循環依存できません")
    end
  end
end
