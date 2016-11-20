module Schedulers
  class Prompt
    def self.run
      Prompters::DailyPrompter.run if its_time?
    end

    def self.its_time?
      Time.zone.now.hour == 1
    end

    private_class_method :its_time?
  end
end
