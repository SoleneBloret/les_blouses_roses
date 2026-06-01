class CreateReports < ActiveRecord::Migration[8.1]
  def change
    create_table :reports do |t|
      t.integer :week_number
      t.integer :patients_number
      t.text :comment
      t.references :permanence, null: false, foreign_key: true

      t.timestamps
    end
  end
end
