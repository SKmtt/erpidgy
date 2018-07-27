class AddIsActiveToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :is_active, :boolean, :default => true
  end
end
