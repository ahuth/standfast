require 'rails_helper'

describe Prompters::DailyPrompter do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    context "on Sunday" do
      before do
        travel_to Date.new(2016, 11, 6) do
          described_class.run
        end
      end

      it "does not send daily prompts" do
        expect(enqueued_jobs.count).to eq(0)
      end
    end

    context "on Monday" do
      before do
        travel_to Date.new(2016, 11, 7) do
          described_class.run
        end
      end

      it "does not send daily prompts" do
        expect(enqueued_jobs.count).to eq(0)
      end
    end

    context "on a weekday" do
      before do
        travel_to Date.new(2016, 11, 8) do
          described_class.run
        end
      end

      it "sends a daily prompt for each team" do
        expect(Team.count).to be > 0
        expect(enqueued_jobs.count).to eq(Team.count)
        expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
      end
    end
  end
end
