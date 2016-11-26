module TimeZones
  class WeekdayHour
    def self.run(hour)
      zones_for_hour(hour).map(&:name)
    end

    def self.zones_for_hour(hour)
      ActiveSupport::TimeZone.all.select do |zone|
        weekday?(zone) && zone.now.hour == hour
      end
    end

    def self.weekday?(zone)
      !(zone.today.saturday? || zone.today.sunday?)
    end

    private_class_method :zones_for_hour
  end
end
