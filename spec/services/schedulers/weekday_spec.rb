require 'rails_helper'

describe Schedulers::Weekday do
  include ActiveJob::TestHelper
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:offset) { ActiveSupport::TimeZone[time_zone].formatted_offset }
    let(:task_double) { double("Task", run: true) }
    let(:test_time) { Time.new(2016, 11, day, test_hour, 0, 0, offset) }

    before do
      travel_to(test_time) do
        described_class.run(task_double, run_at, time_zone)
      end
    end

    context "in Eastern time" do
      let(:time_zone) { "Eastern Time (US & Canada)" }

      context "for 3pm" do
        let(:run_at) { 15 }

        context "on Sunday" do
          let(:day) { 13 }

          before do
            expect(test_time).to be_sunday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Monday" do
          let(:day) { 14 }

          before do
            expect(test_time).to be_monday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "runs the task" do
              expect(task_double).to have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Tuesday" do
          let(:day) { 15 }

          before do
            expect(test_time).to be_tuesday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "runs the task" do
              expect(task_double).to have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Wednesday" do
          let(:day) { 16 }

          before do
            expect(test_time).to be_wednesday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "runs the task" do
              expect(task_double).to have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Thursday" do
          let(:day) { 17 }

          before do
            expect(test_time).to be_thursday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "runs the task" do
              expect(task_double).to have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Friday" do
          let(:day) { 18 }

          before do
            expect(test_time).to be_friday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "runs the task" do
              expect(task_double).to have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end

        context "on Saturday" do
          let(:day) { 19 }

          before do
            expect(test_time).to be_saturday
          end

          context "an hour before" do
            let(:test_hour) { run_at - 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "at the time" do
            let(:test_hour) { run_at }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end

          context "an hour after" do
            let(:test_hour) { run_at + 1 }

            it "does not run the task" do
              expect(task_double).to_not have_received(:run)
            end
          end
        end
      end
    end
  end
end
