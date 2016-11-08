require "rails_helper"

describe PromptMailer, type: :mailer do
  describe "#daily_status_email" do
    let(:team) { teams(:jane_red_team) }
    let(:mail) { described_class.daily_status_email(team) }

    it "sends to everyone on the team" do
      expect(team.seats.count).to be > 0
      expect(mail.to).to match_array(team.seats.pluck(:email))
    end

    it "includes information in the subject" do
      expect(mail.subject).to include("[#{team.id}]")
    end
  end
end
