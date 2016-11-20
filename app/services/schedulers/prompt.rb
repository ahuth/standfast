module Schedulers
  class Prompt
    def self.run
      Schedulers::Weekday.run(Prompters::DailyPrompter, 17, "Pacific Time (US & Canada)")
    end
  end
end
