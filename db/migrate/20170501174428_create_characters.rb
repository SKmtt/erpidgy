class CreateCharacters < ActiveRecord::Migration[5.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :surname
      t.text :description
      t.date :birth
      t.integer :user_id
    end

    add_index :characters, :user_id
  end
end
