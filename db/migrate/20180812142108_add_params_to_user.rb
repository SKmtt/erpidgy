class AddParamsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :display_name, :string
    add_column :users, :status, :string
    add_column :users, :status_text, :string
  end
end
