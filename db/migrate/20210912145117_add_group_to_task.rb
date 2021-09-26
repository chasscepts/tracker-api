class AddGroupToTask < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :group, null: false, foreign_key: true
  end
end
