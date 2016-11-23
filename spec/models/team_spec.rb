require 'rails_helper'

describe Team, type: :model do
  it { should belong_to(:account) }
  it { should have_many(:seats).dependent(:destroy) }
  it { should have_many(:responses).through(:seats) }
  it { should validate_presence_of(:account) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_uniqueness_of(:name).scoped_to(:account_id) }

  describe "scopes" do
    describe "with_unhandled_responses" do
      let(:teams_with_unhandled_responses) { teams(:jane_blue_team) }
      let(:teams_without_unhandled_responses) { teams(:jane_red_team) }
      let(:scoped_ids) { described_class.with_unhandled_responses.pluck(:id) }

      before do
        expect(teams_with_unhandled_responses.responses.unhandled.count).to be > 0
        expect(teams_without_unhandled_responses.responses.unhandled.count).to eq(0)
      end

      it "does not include teams without unhandled repsonses" do
        expect(scoped_ids).to_not include(teams_without_unhandled_responses.id)
      end

      it "includes teams with unhandled responses" do
        expect(scoped_ids).to include(teams_with_unhandled_responses.id)
      end
    end
  end
end
