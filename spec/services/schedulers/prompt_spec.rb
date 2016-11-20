require 'rails_helper'

describe Schedulers::Prompt do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:teams_count) { Team.count }

    before do
      travel_to Time.utc(2016, 11, utc_day, utc_time) do
        described_class.run
      end
    end

    context "on a weekday" do
      let(:november_friday) { 18 }
      let(:utc_day) { november_friday + 1 }

      context "at 4pm" do
        let(:utc_time) { 0 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 5pm" do
        let(:utc_time) { 1 }

        it "sends a daily prompt for each team" do
          expect(teams_count).to be > 0
          expect(enqueued_jobs.count).to eq(teams_count)
          expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
        end
      end
    end

    context "on a weekend" do
      let(:november_saturday) { 19 }
      let(:utc_day) { november_saturday + 1 }

      context "at 4pm" do
        let(:utc_time) { 0 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 5pm" do
        let(:utc_time) { 1 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end
    end
  end
end
