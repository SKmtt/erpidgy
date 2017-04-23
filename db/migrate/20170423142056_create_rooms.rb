class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.string :resources_url

      t.timestamps
    end

    add_column :replies, :room_id, :integer

    add_index :replies, :room_id
  end
end
