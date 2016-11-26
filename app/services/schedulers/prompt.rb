module Schedulers
  class Prompt
    def self.run
      Schedulers::Weekday.run(Daily::Prompt, 17, "Pacific Time (US & Canada)")
    end
  end
end
