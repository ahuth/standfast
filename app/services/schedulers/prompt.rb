module Schedulers
  class Prompt
    def self.run
      Prompters::DailyPrompter.run if !weekend? && its_time?
    end

    def self.its_time?
      Time.zone.now.hour == 1
    end

    def self.weekend?
      Time.zone.today.sunday? || Time.zone.today.monday?
    end

    private_class_method :its_time?
    private_class_method :weekend?
  end
end
