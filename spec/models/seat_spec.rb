require 'rails_helper'

describe Seat, type: :model do
  describe "validations" do
    let(:seat) { seats(:bob_black_team_bill_seat) }

    before do
      expect(seat).to be_valid
    end

    context "without a name" do
      before do
        seat.name = nil
      end

      it "is invalid" do
        expect(seat).to_not be_valid
        expect(seat.errors.full_messages).to eq(["Name can't be blank"])
      end
    end

    context "without an email" do
      before do
        seat.email = nil
      end

      it "is invalid" do
        expect(seat).to_not be_valid
        expect(seat.errors.full_messages).to eq(["Email can't be blank"])
      end
    end

    context "without a team" do
      before do
        seat.team = nil
      end

      it "is invalid" do
        expect(seat).to_not be_valid
        expect(seat.errors.full_messages).to eq(["Team must exist"])
      end
    end

    context "with the email of another seat from the same team" do
      let(:other_seat) { seats(:bob_black_team_ted_seat) }

      before do
        expect(seat.team_id).to eq(other_seat.team_id)
        seat.email = other_seat.email
      end

      it "is invalid" do
        expect(seat).to_not be_valid
        expect(seat.errors.full_messages).to eq(["Email has already been taken"])
      end
    end

    context "with the email of another seat from a different team" do
      let(:other_seat) { seats(:bob_pink_team_jill_seat) }

      before do
        expect(seat.team_id).to_not eq(other_seat.team_id)
        seat.email = other_seat.email
      end

      it "is still valid" do
        expect(seat).to be_valid
      end
    end
  end
end
