require 'rails_helper'

describe Schedulers::Summary do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let!(:unhandled_teams_count) { Team.joins(:responses).where("responses.handled = false").distinct.count }

    context "on a weekday" do
      context "at 6am" do
        before do
          travel_to Time.utc(2016, 11, 18, 14) do
            described_class.run
          end
        end

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 7am" do
        before do
          travel_to Time.utc(2016, 11, 18, 15) do
            described_class.run
          end
        end

        it "sends a daily prompt to each team with unhandled responses" do
          expect(unhandled_teams_count).to be > 0
          expect(enqueued_jobs.count).to eq(unhandled_teams_count)
          expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
        end
      end
    end

    context "on a weekend" do
      context "at 6am" do
        before do
          travel_to Time.utc(2016, 11, 19, 14) do
            described_class.run
          end
        end

        it "does not send daily prompts" do
          expect(enqueued_jobs.count).to eq(0)
        end
      end

      context "at 7am" do
        before do
          travel_to Time.utc(2016, 11, 19, 15) do
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
