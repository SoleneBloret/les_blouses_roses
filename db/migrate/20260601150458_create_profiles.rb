class CreateProfiles < ActiveRecord::Migration[8.1]
  def change
    create_table :profiles do |t|
      t.string :address
      t.string :role
      t.string :phone_number
      t.string :first_name
      t.string :last_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
