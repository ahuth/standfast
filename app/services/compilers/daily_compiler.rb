module Compilers
  class DailyCompiler
    def self.run
      if !pacific_weekend_in_utc?
        teams_with_unhandled_responses.find_each do |team|
          SummaryMailer.daily_summary_email(team).deliver_later
        end
        responses_from_unhandled_teams.where(handled: false).update_all(handled: true)
      end
    end

    def self.pacific_weekend_in_utc?
      today = Date.today
      today.sunday? || today.monday?
    end

    def self.teams_with_unhandled_responses
      Team.joins(:responses).where("responses.handled = false")
    end

    def self.seats_from_unhandled_teams
      Seat.joins(:team).where("team_id in (?)", teams_with_unhandled_responses.pluck(:id))
    end

    def self.responses_from_unhandled_teams
      Response.joins(:seat).where("seat_id in (?)", seats_from_unhandled_teams.pluck(:id))
    end

    private_class_method :pacific_weekend_in_utc?
    private_class_method :teams_with_unhandled_responses
    private_class_method :seats_from_unhandled_teams
    private_class_method :responses_from_unhandled_teams
  end
end
