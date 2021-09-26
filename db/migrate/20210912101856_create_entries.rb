class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.date :entry_date
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
