module Schedulers
  class Summary
    def self.run
      Schedulers::Weekday.run(Compilers::DailyCompiler, 7, "Pacific Time (US & Canada)")
    end
  end
end
