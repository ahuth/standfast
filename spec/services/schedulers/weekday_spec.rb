require 'rails_helper'

describe Schedulers::Weekday do
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:eastern_team) { teams(:bob_pink_team) }
    let(:pacific_team) { teams(:jane_red_team) }
    let(:task_double) { double("Task", run: true) }
    let(:test_time) { Time.utc(2016, 11, utc_day, utc_hour) }

    before do
      expect(eastern_team.time_zone).to eq("Eastern Time (US & Canada)")
      expect(pacific_team.time_zone).to eq("Pacific Time (US & Canada)")
      travel_to(test_time) do
        described_class.run(task_double, test_hour)
      end
    end

    context "for 6pm" do
      let(:test_hour) { 18 }
      let(:eastern_time) { test_time.in_time_zone("Eastern Time (US & Canada)") }
      let(:pacific_time) { test_time.in_time_zone("Pacific Time (US & Canada)") }

      context "at 11pm UTC (6pm eastern time)" do
        let(:utc_hour) { 23 }

        before do
          expect(eastern_time.hour).to eq(test_hour)
          expect(pacific_time.hour).to_not eq(test_hour)
        end

        context "on a weekday" do
          let(:utc_day) { 25 }

          before do
            expect(eastern_time).to be_friday
          end

          it "runs the task for teams where it's 6pm" do
            expect(task_double).to have_received(:run) do |teams|
              expect(teams.pluck(:id)).to include(eastern_team.id)
            end
          end

          it "does not run the task for teams where it's not 6pm" do
            expect(task_double).to have_received(:run) do |teams|
              expect(teams.pluck(:id)).to_not include(pacific_team.id)
            end
          end
        end

        context "on a weekend" do
          let(:utc_day) { 26 }

          before do
            expect(eastern_time).to be_saturday
          end

          it "does not run the task" do
            expect(task_double).to_not have_received(:run)
          end
        end
      end

      context "at 2am UTC (6pm pacific time)" do
        let(:utc_hour) { 2 }

        before do
          expect(pacific_time.hour).to eq(test_hour)
          expect(eastern_time.hour).to_not eq(test_hour)
        end

        context "on a weekday" do
          let(:utc_day) { 26 }

          before do
            expect(pacific_time).to be_friday
          end

          it "runs the task for teams where it's 6pm" do
            expect(task_double).to have_received(:run) do |teams|
              expect(teams.pluck(:id)).to include(pacific_team.id)
            end
          end

          it "does not run the task for teams where it's not 6pm" do
            expect(task_double).to have_received(:run) do |teams|
              expect(teams.pluck(:id)).to_not include(eastern_team.id)
            end
          end
        end

        context "on a weekend" do
          let(:utc_day) { 27 }

          before do
            expect(pacific_time).to be_saturday
          end

          it "does not run the task" do
            expect(task_double).to_not have_received(:run)
          end
        end
      end
    end
  end
end
