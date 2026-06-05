class ChangeColumnDefaultSubstituteFromParticipations < ActiveRecord::Migration[8.1]
  def change
    change_column_default :participations, :substitute, false
  end
end
