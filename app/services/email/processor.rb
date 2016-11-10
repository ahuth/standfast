module Email
  class Processor
    def initialize(email)
      @email = email
    end

    def process
      return unless team && seat
      unhandled_responses.update_all(handled: true)
      Response.create!(seat: seat, body: @email.body)
    end

    private

    def from_email
      @email.from[:email]
    end

    def team_id
      team_id_match && team_id_match[1]
    end

    def team_id_match
      @team_id_match ||= @email.subject.match(/\[(\d+)\]$/)
    end

    def team
      @team ||= Team.find_by(id: team_id)
    end

    def unhandled_responses
      seat.responses.where(handled: false)
    end

    def seat
      @seat ||= team.seats.find_by(email: from_email)
    end
  end
end
