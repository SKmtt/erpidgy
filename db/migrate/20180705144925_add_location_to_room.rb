class AddLocationToRoom < ActiveRecord::Migration[5.0]
  def change
    add_reference :rooms, :location, foreign_key: true
  end
end
