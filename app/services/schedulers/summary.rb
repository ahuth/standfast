module Schedulers
  class Summary
    def self.run
      Schedulers::Weekday.run(Summarizers::DailySummarizer, 7, "Pacific Time (US & Canada)")
    end
  end
end
