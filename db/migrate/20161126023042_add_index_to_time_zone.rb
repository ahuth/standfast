class AddIndexToTimeZone < ActiveRecord::Migration[5.0]
  def change
    add_index :teams, :time_zone
  end
end
