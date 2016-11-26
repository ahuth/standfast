module Schedulers
  class Weekday
    def self.run(task, hour)
      teams = teams_to_run(hour)
      task.run(teams) if teams.count > 0
    end

    def self.teams_to_run(time)
      zones = TimeZones::WeekdayHour.run(time)
      Team.where(time_zone: zones)
    end
  end
end
