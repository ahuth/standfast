module Schedulers
  class Summary
    def self.run
      Schedulers::Weekday.run(Daily::Summary, 7)
    end
  end
end
