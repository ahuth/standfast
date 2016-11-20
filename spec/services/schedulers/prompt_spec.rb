require 'rails_helper'

describe Schedulers::Prompt do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:teams_count) { Team.count }

    context "on a weekday" do
      context "at 4pm" do
        before do
          travel_to Time.utc(2016, 11, 19, 0) do
            described_class.run
          end
        end

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 5pm" do
        before do
          travel_to Time.utc(2016, 11, 19, 1) do
            described_class.run
          end
        end

        it "sends a daily prompt for each team" do
          expect(teams_count).to be > 0
          expect(enqueued_jobs.count).to eq(teams_count)
          expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
        end
      end
    end

    context "on a weekend" do
      context "at 4pm" do
        before do
          travel_to Time.utc(2016, 11, 20, 0) do
            described_class.run
          end
        end

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 5pm" do
        before do
          travel_to Time.utc(2016, 11, 20, 1) do
            described_class.run
          end
        end

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end
    end
  end
end
