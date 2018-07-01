class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.references :character, foreign_key: true
      t.string :name
      t.string :description
      t.string :img_location

      t.timestamps
    end
  end
end
