class CreateReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :replies do |t|
      t.text :text
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :user_id

      t.timestamps
    end

    add_index :replies, :user_id
  end
end
