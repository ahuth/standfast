class AddTimeZoneToTeams < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :time_zone, :string

    reversible do |direction|
      direction.up do
        say_with_time "Backfilling teams with pacfic time zone" do
          Team.update_all(time_zone: "Pacific Time (US & Canada)")
        end
      end
    end

    change_column_null :teams, :time_zone, false
  end
end
