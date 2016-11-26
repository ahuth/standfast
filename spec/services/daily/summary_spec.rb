require "rails_helper"

describe Daily::Summary do
  include ActiveJob::TestHelper

  describe ".run" do
    let!(:initial_unhandled_team_count) { unhandled_teams.count }
    let(:unhandled_teams) { teams.with_unhandled_responses }
    let(:teams) { Team.all }

    before do
      expect(initial_unhandled_team_count).to be > 0
      expect(initial_unhandled_team_count).to be < Team.count
      described_class.run(teams)
    end

    it "sends a daily summary to each provided team with unhandled responses" do
      expect(enqueued_jobs.count).to eq(initial_unhandled_team_count)
      expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
    end

    it "sets handled to true for the responses" do
      expect(teams.with_unhandled_responses.count).to eq(0)
    end
  end
end
