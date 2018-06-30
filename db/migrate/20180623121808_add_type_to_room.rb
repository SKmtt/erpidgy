class AddTypeToRoom < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :is_public, :boolean
  end
end
