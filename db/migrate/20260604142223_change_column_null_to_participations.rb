class ChangeColumnNullToParticipations < ActiveRecord::Migration[8.1]
  def change
    change_column_null :participations, :user_id, true
  end
end
