require "rails_helper"

describe SummaryMailer, type: :mailer do
  describe "#daily_summary_email" do
    let(:team) { teams(:jane_blue_team) }
    let(:mail) { described_class.daily_summary_email(team) }
    let(:body) { mail.text_part.body.encoded }

    it "sends to everyone on the team" do
      expect(team.seats.count).to be > 0
      expect(mail.to).to match_array(team.seats.pluck(:email))
    end

    context "for unhandled responses" do
      let(:unhandled_responses) { team.responses.unhandled }

      before do
        expect(unhandled_responses.count).to be > 0
      end

      it "includes them" do
        unhandled_responses.each do |response|
          expect(body).to match(response.seat.name)
        end
      end
    end

    context "for handled responses" do
      let(:handled_responses) { team.responses.handled }

      before do
        expect(handled_responses.count).to be > 0
      end

      it "does not include them" do
        handled_responses.each do |response|
          expect(body).to_not match(response.seat.name)
        end
      end
    end
  end
end
