class CurrentCharacter < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :current_character
    add_column :characters, :profile_image, :string
  end
end
