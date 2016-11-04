require 'rails_helper'

describe Response, type: :model do
  fixtures :responses

  describe "validations" do
    let(:response) { responses(:jane_blue_team_shirish_seat_response_1) }

    before do
      expect(response).to be_valid
    end

    context "without a body" do
      before do
        response.body = nil
      end

      it "is invalid" do
        expect(response).to_not be_valid
        expect(response.errors.full_messages).to eq(["Body can't be blank"])
      end
    end

    context "without a seat" do
      before do
        response.seat = nil
      end

      it "is invalid" do
        expect(response).to_not be_valid
        expect(response.errors.full_messages).to eq(["Seat must exist"])
      end
    end
  end
end
