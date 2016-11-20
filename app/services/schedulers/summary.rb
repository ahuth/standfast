module Schedulers
  class Summary
    def self.run
      Compilers::DailyCompiler.run if !weekend? && its_time?
    end

    def self.its_time?
      Time.zone.now.hour == 15
    end

    def self.weekend?
      Time.zone.today.saturday? || Time.zone.today.sunday?
    end

    private_class_method :its_time?
    private_class_method :weekend?
  end
end
