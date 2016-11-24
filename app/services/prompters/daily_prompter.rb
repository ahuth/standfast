module Prompters
  class DailyPrompter
    def self.run
      Team.includes(:seats).find_each do |team|
        PromptMailer.daily_status_email(team).deliver_later
      end
    end
  end
end
