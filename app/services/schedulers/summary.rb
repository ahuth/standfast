module Schedulers
  class Summary
    def self.run
      Schedulers::Weekday.run(Daily::Summary, 7, "Pacific Time (US & Canada)")
    end
  end
end
