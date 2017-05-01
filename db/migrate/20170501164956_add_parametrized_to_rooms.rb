class AddParametrizedToRooms < ActiveRecord::Migration[5.0]
  def change
    add_column :rooms, :parametrized, :string
  end
end
