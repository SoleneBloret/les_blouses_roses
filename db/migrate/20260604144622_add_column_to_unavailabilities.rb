class AddColumnToUnavailabilities < ActiveRecord::Migration[8.1]
  def change
    add_column :unavailabilities, :week_numbers, :integer, array: true, default: []
  end
end
