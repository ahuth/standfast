module Prompters
  class DailyPrompter
    def self.run
      if !pacific_weekend_in_utc?
        Team.find_each do |team|
          PromptMailer.daily_status_email(team).deliver_later
        end
      end
    end

    def self.pacific_weekend_in_utc?
      today = Date.today
      today.sunday? || today.monday?
    end

    private_class_method :pacific_weekend_in_utc?
  end
end
