require "rails_helper"

describe Summarizers::DailySummarizer do
  include ActiveJob::TestHelper

  describe ".run" do
    let!(:initial_unhandled_team_count) { unhandled_teams.count }

    before do
      described_class.run
    end

    def unhandled_teams
      Team.joins(:responses).where("responses.handled = false").distinct
    end

    it "sends a daily summary to each team with unhandled responses" do
      expect(initial_unhandled_team_count).to be > 0
      expect(initial_unhandled_team_count).to be < Team.count
      expect(enqueued_jobs.count).to eq(1)
      expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
    end

    it "sets handled to true for the responses" do
      expect(unhandled_teams.count).to eq(0)
    end
  end
end
