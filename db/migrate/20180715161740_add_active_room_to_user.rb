class AddActiveRoomToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :active_room, foreign_key: true
  end
end
