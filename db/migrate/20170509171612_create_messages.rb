class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :scope
      t.references :character, foreign_key: true
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
