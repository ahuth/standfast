class EnsureRepsonseHasSeat < ActiveRecord::Migration[5.0]
  def change
    change_column_null :responses, :seat_id, false
  end
end
