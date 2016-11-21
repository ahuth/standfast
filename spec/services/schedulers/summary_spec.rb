require 'rails_helper'

describe Schedulers::Summary do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let!(:unhandled_teams_count) { Team.with_unhandled_responses.count }

    before do
      travel_to Time.utc(2016, 11, utc_day, utc_time) do
        described_class.run
      end
    end

    context "on a weekday" do
      let(:november_friday) { 18 }
      let(:utc_day) { november_friday }

      context "at 6am" do
        let(:utc_time) { 14 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 7am" do
        let(:utc_time) { 15 }

        it "sends a daily prompt to each team with unhandled responses" do
          expect(unhandled_teams_count).to be > 0
          expect(enqueued_jobs.count).to eq(unhandled_teams_count)
          expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
        end
      end
    end

    context "on a weekend" do
      let(:november_saturday) { 19 }
      let(:utc_day) { november_saturday }

      context "at 6am" do
        let(:utc_time) { 14 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 7am" do
        let(:utc_time) { 15 }

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end
    end
  end
end
