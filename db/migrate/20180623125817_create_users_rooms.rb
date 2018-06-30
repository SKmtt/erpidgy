class CreateUsersRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :users_rooms do |t|
      t.string :status
      t.boolean :can_add_place
      t.boolean :open
      t.belongs_to :user, foreign_key: true
      t.belongs_to :room, foreign_key: true

      t.timestamps
    end
  end
end
