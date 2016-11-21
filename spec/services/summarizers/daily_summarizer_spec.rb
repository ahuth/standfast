require "rails_helper"

describe Summarizers::DailySummarizer do
  include ActiveJob::TestHelper

  describe ".run" do
    let!(:initial_unhandled_team_count) { Team.with_unhandled_responses.count }

    before do
      described_class.run
    end

    it "sends a daily summary to each team with unhandled responses" do
      expect(initial_unhandled_team_count).to be > 0
      expect(initial_unhandled_team_count).to be < Team.count
      expect(enqueued_jobs.count).to eq(1)
      expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
    end

    it "sets handled to true for the responses" do
      expect(Team.with_unhandled_responses.count).to eq(0)
    end
  end
end
