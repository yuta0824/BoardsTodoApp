class CreateTaskDependencies < ActiveRecord::Migration[7.2]
  def change
    create_table :task_dependencies do |t|
      t.references :predecessor, null: false, foreign_key: { to_table: :tasks }
      t.references :successor, null: false, foreign_key: { to_table: :tasks }
      t.timestamps
      t.index [:predecessor_id, :successor_id], unique: true, name: 'index_task_deps_on_predecessor_and_successor'
    end
  end
end
