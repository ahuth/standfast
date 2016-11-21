module Summarizers
  class DailySummarizer
    def self.run
      send_summaries!
      mark_responses!
    end

    def self.send_summaries!
      Team.with_unhandled_responses.find_each do |team|
        SummaryMailer.daily_summary_email(team).deliver_later
      end
    end

    def self.mark_responses!
      Response.unhandled.update_all(handled: true)
    end

    private_class_method :mark_responses!
    private_class_method :send_summaries!
  end
end
