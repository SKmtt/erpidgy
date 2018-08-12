class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    # TODO delete this
    create_table :profiles do |t|
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
