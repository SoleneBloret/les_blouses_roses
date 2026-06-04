class ChangeFeelingIntoInteger < ActiveRecord::Migration[8.1]
  def change
    remove_column :reports, :feeling, :string
    add_column :reports, :feeling, :integer
  end
end
