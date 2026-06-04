class CreateUnavailabilities < ActiveRecord::Migration[8.1]
  def change
    create_table :unavailabilities do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :reason

      t.timestamps
    end
  end
end
