class CreateDefaultTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :default_tasks do |t|
      t.string :title
      t.references :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
