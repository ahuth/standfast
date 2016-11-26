module Prompters
  class DailyPrompter
    def self.run(teams)
      teams.includes(:seats).find_each do |team|
        PromptMailer.daily_status_email(team).deliver_later
      end
    end
  end
end
