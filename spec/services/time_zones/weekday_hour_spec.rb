require "rails_helper"

describe TimeZones::WeekdayHour do
  include ActiveSupport::Testing::TimeHelpers

  describe ".run" do
    let(:results) { described_class.run(schedule_hour) }
    let(:test_time) { zone.local(2016, 11, day, hour) }
    let(:zone) { ActiveSupport::TimeZone["UTC"] }

    before do
      travel_to(test_time)
    end

    after do
      travel_back
    end

    context "for 10am" do
      let(:schedule_hour) { 10 }

      context "on a weekday" do
        let(:day) { 25 }

        before do
          expect(test_time).to be_friday
        end

        context "at UTC midnight" do
          let(:hour) { 0 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to match_array(["Adelaide", "Brisbane", "Guam", "Port Moresby", "Vladivostok"])
          end
        end

        context "at UTC 6am" do
          let(:hour) { 6 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to match_array(["Abu Dhabi", "Baku", "Kabul", "Muscat", "Samara", "Tbilisi", "Yerevan"])
          end
        end

        context "at UTC 12pm" do
          let(:hour) { 12 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to match_array(["Brasilia", "Mid-Atlantic"])
          end
        end

        context "at UTC 6pm" do
          let(:hour) { 18 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to match_array(["Pacific Time (US & Canada)", "Tijuana"])
          end
        end
      end

      context "on a weekday" do
        let(:day) { 26 }

        before do
          expect(test_time).to be_saturday
        end

        context "at UTC midnight" do
          let(:hour) { 0 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to eq([])
          end
        end

        context "at UTC 6am" do
          let(:hour) { 6 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to eq([])
          end
        end

        context "at UTC 12pm" do
          let(:hour) { 12 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to eq([])
          end
        end

        context "at UTC 6pm" do
          let(:hour) { 18 }

          it "returns time zones currently at the specified hour on a weekday" do
            expect(results).to eq([])
          end
        end
      end
    end
  end
end
