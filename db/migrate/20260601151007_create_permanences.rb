class CreatePermanences < ActiveRecord::Migration[8.1]
  def change
    create_table :permanences do |t|
      t.string :week_day
      t.integer :start_time
      t.integer :end_time
      t.boolean :formation
      t.string :service
      t.integer :year
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
