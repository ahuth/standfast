require "rails_helper"

describe Schedulers::Prompt do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:test_time) { zone.local(2016, 11, day, hour) }

    before do
      travel_to(test_time) do
        described_class.run
      end
    end

    context "in the pacific time zone" do
      let(:zone) { ActiveSupport::TimeZone["Pacific Time (US & Canada)"] }
      let(:pacific_teams) { Team.where(time_zone: zone.name) }

      before do
        expect(pacific_teams.count).to be > 0
      end

      context "on a weekday" do
        let(:day) { 18 }

        before do
          expect(test_time).to be_friday
        end

        context "at 4pm" do
          let(:hour) { 16 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end

        context "at 5pm" do
          let(:hour) { 17 }

          it "sends a daily prompt for each team where its 5pm" do
            expect(enqueued_jobs.count).to eq(pacific_teams.count)
            expect(enqueued_jobs.last[:args].first).to eq("PromptMailer")
          end
        end
      end

      context "on a weekend" do
        let(:day) { 19 }

        before do
          expect(test_time).to be_saturday
        end

        context "at 4pm" do
          let(:hour) { 16 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end

        context "at 5pm" do
          let(:hour) { 17 }

          it "does not send daily prompts" do
            expect(enqueued_jobs.count).to eq(0)
          end
        end
      end
    end
  end
end
