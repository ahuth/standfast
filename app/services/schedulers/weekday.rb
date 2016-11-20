module Schedulers
  class Weekday
    def self.run(task, time, time_zone)
      task.run if !weekend?(time_zone) && is_time?(time, time_zone)
    end

    def self.is_time?(time, time_zone)
      now = ActiveSupport::TimeZone[time_zone].now
      now.hour == time
    end

    def self.weekend?(time_zone)
      today = ActiveSupport::TimeZone[time_zone].today
      today.saturday? || today.sunday?
    end

    private_class_method :is_time?
    private_class_method :weekend?
  end
end
