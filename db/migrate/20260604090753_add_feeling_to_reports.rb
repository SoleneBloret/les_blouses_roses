class AddFeelingToReports < ActiveRecord::Migration[8.1]
  def change
    add_column :reports, :feeling, :integer unless column_exists?(:reports, :feeling)
  end
end
