module Prompters
  class DailyPrompter
    def self.run
      if !pacific_weekend_in_utc?
        Team.find_each do |team|
          PromptMailer.daily_status_email(team).deliver_later
        end
      end
    end

    # This object will be ran everyday at 5:00 pm pacific time. However, we don't
    # want to send it on weekends. The scheduler runs in UTC, and we need to take
    # that into consideration. That time is currently the _next_ day in UTC.
    def self.pacific_weekend_in_utc?
      today = Date.today
      today.sunday? || today.monday?
    end

    private_class_method :pacific_weekend_in_utc?
  end
end
