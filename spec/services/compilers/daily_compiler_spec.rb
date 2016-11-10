require "rails_helper"

describe Compilers::DailyCompiler do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    context "on Sunday" do
      before do
        travel_to Date.new(2016, 11, 6) do
          described_class.run
        end
      end

      it "does not send daily summary" do
        expect(enqueued_jobs.count).to eq(0)
      end
    end

    context "on Monday" do
      before do
        travel_to Date.new(2016, 11, 7) do
          described_class.run
        end
      end

      it "does not send daily summary" do
        expect(enqueued_jobs.count).to eq(0)
      end
    end

    context "on a weekday" do
      let!(:initial_unhandled_team_count) { unhandled_teams.count }

      before do
        travel_to Date.new(2016, 11, 8) do
          described_class.run
        end
      end

      def unhandled_teams
        Team.joins(:responses).where("responses.handled = false")
      end

      it "sends a daily summary to each team with unhandled responses" do
        expect(initial_unhandled_team_count).to be > 0
        expect(initial_unhandled_team_count).to be < Team.count
        expect(enqueued_jobs.count).to eq(initial_unhandled_team_count)
        expect(enqueued_jobs.last[:args].first).to eq("SummaryMailer")
      end

      it "sets handled to true for the responses" do
        expect(unhandled_teams.count).to eq(0)
      end
    end
  end
end
