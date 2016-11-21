require 'rails_helper'

describe Team, type: :model do
  describe "validations" do
    let(:team) { teams(:jane_blue_team) }

    before do
      expect(team).to be_valid
    end

    context "without a name" do
      before do
        team.name = nil
      end

      it "is invalid" do
        expect(team).to_not be_valid
        expect(team.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context "with a long name" do
      before do
        team.name = "a" * 256
      end

      it "is invalid" do
        expect(team).to_not be_valid
        expect(team.errors.full_messages).to eq(["Name is too long (maximum is 255 characters)"])
      end
    end

    context "with the name of another team from the same account" do
      let(:other_team) { teams(:jane_red_team) }

      before do
        expect(team.account_id).to eq(other_team.account_id)
        team.name = other_team.name
      end

      it "is invalid" do
        expect(team).to_not be_valid
        expect(team.errors.full_messages).to eq(["Name has already been taken"])
      end
    end

    context "with the name of another team from a different account" do
      let(:other_team) { teams(:bob_black_team) }

      before do
        expect(team.account_id).to_not eq(other_team.account_id)
        team.name = other_team.name
      end

      it "is still valid" do
        expect(team).to be_valid
      end
    end
  end

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
