require 'rails_helper'
require 'support/shared_examples/schedulers'

describe Schedulers::Weekday do
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:offset) { ActiveSupport::TimeZone[time_zone].formatted_offset }
    let(:task_double) { double("Task", run: true) }
    let(:test_time) { Time.new(2016, 11, day, test_hour, 0, 0, offset) }

    context "in Eastern time" do
      let(:time_zone) { "Eastern Time (US & Canada)" }

      context "for 3pm" do
        run_at = 15

        context "on Sunday" do
          let(:day) { 13 }

          before do
            expect(test_time).to be_sunday
          end

          it_behaves_like "it does not get scheduled", run_at
        end

        context "on Monday" do
          let(:day) { 14 }

          before do
            expect(test_time).to be_monday
          end

          it_behaves_like "it gets scheduled", run_at
        end

        context "on Tuesday" do
          let(:day) { 15 }

          before do
            expect(test_time).to be_tuesday
          end

          it_behaves_like "it gets scheduled", run_at
        end

        context "on Wednesday" do
          let(:day) { 16 }

          before do
            expect(test_time).to be_wednesday
          end

          it_behaves_like "it gets scheduled", run_at
        end

        context "on Thursday" do
          let(:day) { 17 }

          before do
            expect(test_time).to be_thursday
          end

          it_behaves_like "it gets scheduled", run_at
        end

        context "on Friday" do
          let(:day) { 18 }

          before do
            expect(test_time).to be_friday
          end

          it_behaves_like "it gets scheduled", run_at
        end

        context "on Saturday" do
          let(:day) { 19 }

          before do
            expect(test_time).to be_saturday
          end

          it_behaves_like "it does not get scheduled", run_at
        end
      end
    end
  end
end
