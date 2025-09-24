class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :board, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description
      t.date :due_date
      t.timestamps
    end
  end
end
