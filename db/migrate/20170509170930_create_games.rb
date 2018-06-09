class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string :state

      t.timestamps
    end
  end
end
