shared_examples "it does not get scheduled" do |hour|
  before do
    travel_to(test_time) do
      described_class.run(task_double, hour, time_zone)
    end
  end

  context "an hour before" do
    let(:test_hour) { hour - 1 }

    it "does not run the task" do
      expect(task_double).to_not have_received(:run)
    end
  end

  context "at the time" do
    let(:test_hour) { hour }

    it "does not run the task" do
      expect(task_double).to_not have_received(:run)
    end
  end

  context "an hour after" do
    let(:test_hour) { hour + 1 }

    it "does not run the task" do
      expect(task_double).to_not have_received(:run)
    end
  end
end

shared_examples "it gets scheduled" do |hour|
  before do
    travel_to(test_time) do
      described_class.run(task_double, hour, time_zone)
    end
  end

  context "an hour before" do
    let(:test_hour) { hour - 1 }

    it "does not run the task" do
      expect(task_double).to_not have_received(:run)
    end
  end

  context "at the time" do
    let(:test_hour) { hour }

    it "runs the task" do
      expect(task_double).to have_received(:run)
    end
  end

  context "an hour after" do
    let(:test_hour) { hour + 1 }

    it "does not run the task" do
      expect(task_double).to_not have_received(:run)
    end
  end
end
