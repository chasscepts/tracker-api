class AddDurationToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :duration, :integer, default: 0
  end
end
