require "rails_helper"

describe Schedulers::Summary do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:test_time) { zone.local(2016, 11, day, hour) }
    let(:zone) { ActiveSupport::TimeZone["Pacific Time (US & Canada)"] }

    context "in the pacific time zone" do
      let!(:initial_unhandled_teams_count) { unhandled_teams.count }
      let(:zone) { ActiveSupport::TimeZone["Pacific Time (US & Canada)"] }
      let(:pacific_teams) { Team.where(time_zone: zone.name) }
      let(:unhandled_teams) { pacific_teams.with_unhandled_responses }

      before do
        expect(unhandled_teams.count).to be > 0
        travel_to(test_time) do
          described_class.run
        end
      end

      context "on a weekday" do
        let(:day) { 18 }

        before do
          expect(test_time).to be_friday
        end

        context "at 6am" do
          let(:hour) { 6 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end

        context "at 7am" do
          let(:hour) { 7 }

          it "sends a daily prompt to each team with unhandled responses" do
            expect(enqueued_jobs.count).to eq(initial_unhandled_teams_count)
            expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
          end
        end
      end

      context "on a weekend" do
        let(:day) { 19 }

        before do
          expect(test_time).to be_saturday
        end

        context "at 6am" do
          let(:hour) { 6 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end

        context "at 7am" do
          let(:hour) { 7 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end
      end
    end
  end
end
