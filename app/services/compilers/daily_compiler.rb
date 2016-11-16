module Compilers
  class DailyCompiler
    def self.run
      if !pacific_weekend_in_utc?
        send_summaries!
        mark_responses!
      end
    end

    def self.send_summaries!
      teams_with_unhandled_responses.find_each do |team|
        SummaryMailer.daily_summary_email(team).deliver_later
      end
    end

    def self.mark_responses!
      Response.where(handled: false).update_all(handled: true)
    end

    # This object will be ran everyday at 9:30 am pacific time. However, we don't
    # want to send it on weekends. The scheduler runs in UTC, and we need to take
    # that into consideration. Fortunately, 9:30 am is 5:30 pm of the same day in
    # UTC.
    def self.pacific_weekend_in_utc?
      today = Date.today
      today.saturday? || today.sunday?
    end

    def self.teams_with_unhandled_responses
      Team.joins(:responses).where("responses.handled = false").distinct
    end

    private_class_method :pacific_weekend_in_utc?
    private_class_method :teams_with_unhandled_responses
  end
end
