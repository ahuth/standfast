require "rails_helper"

describe Daily::Prompt do
  include ActiveJob::TestHelper

  describe ".run" do
    let(:teams) { Team.all }

    before do
      expect(teams.count).to be > 0
      described_class.run(teams)
    end

    it "sends a daily prompt to each provided team" do
      expect(enqueued_jobs.count).to eq(teams.count)
      expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
    end
  end
end
