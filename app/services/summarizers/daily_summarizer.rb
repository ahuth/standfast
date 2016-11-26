module Summarizers
  class DailySummarizer
    def self.run(teams)
      teams.with_unhandled_responses.includes(:responses, :seats).find_each do |team|
        SummaryMailer.daily_summary_email(team).deliver_later
        team.responses.unhandled.update_all(handled: true)
      end
    end
  end
end
