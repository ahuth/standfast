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

    context "with the name of another team from the same user" do
      let(:other_team) { teams(:jane_red_team) }

      before do
        expect(team.user_id).to eq(other_team.user_id)
        team.name = other_team.name
      end

      it "is invalid" do
        expect(team).to_not be_valid
        expect(team.errors.full_messages).to eq(["Name has already been taken"])
      end
    end

    context "with the name of another team from a different user" do
      let(:other_team) { teams(:bob_black_team) }

      before do
        expect(team.user_id).to_not eq(other_team.user_id)
        team.name = other_team.name
      end

      it "is still valid" do
        expect(team).to be_valid
      end
    end
  end
end
