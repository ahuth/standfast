require 'rails_helper'

describe Prompters::DailyPrompter do
  include ActiveJob::TestHelper

  describe ".run" do
    before do
      described_class.run
    end

    it "sends a daily prompt for each team" do
      expect(Team.count).to be > 0
      expect(enqueued_jobs.count).to eq(Team.count)
      expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
    end
  end
end
