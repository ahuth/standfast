module Compilers
  class DailyCompiler
    def self.run
      send_summaries!
      mark_responses!
    end

    def self.send_summaries!
      teams_with_unhandled_responses.find_each do |team|
        SummaryMailer.daily_summary_email(team).deliver_later
      end
    end

    def self.mark_responses!
      Response.where(handled: false).update_all(handled: true)
    end

    def self.teams_with_unhandled_responses
      Team.joins(:responses).where("responses.handled = false").distinct
    end

    private_class_method :mark_responses!
    private_class_method :send_summaries!
    private_class_method :teams_with_unhandled_responses
  end
end
