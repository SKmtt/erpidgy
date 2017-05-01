class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :surname
      t.text :description
      t.date :birth
      t.integer :user_id
    end

    remove_index :replies, :user_id
    remove_column :replies, :user_id

    add_column :replies, :character_id, :integer
    add_index :replies, :character_id

    add_index :characters, :user_id
  end
end
