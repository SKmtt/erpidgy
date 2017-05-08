class CharacterAddStatus < ActiveRecord::Migration[5.0]
  def change
    add_column :characters, :status, :string, default: "pending"
  end
end
