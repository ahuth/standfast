require 'rails_helper'

describe Response, type: :model do
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

  describe "scopes" do
    describe "unhandled" do
      let(:handled_response) { responses(:jane_blue_team_adam_seat_response_1) }
      let(:unhandled_response) { responses(:jane_blue_team_ryan_seat_response_1) }
      let(:scoped_ids) { described_class.unhandled.pluck(:id) }

      before do
        expect(handled_response).to be_handled
        expect(unhandled_response).to_not be_handled
      end

      it "includes unhandled response" do
        expect(scoped_ids).to include(unhandled_response.id)
      end

      it "excludes handled responses" do
        expect(scoped_ids).to_not include(handled_response.id)
      end
    end
  end

  describe "before save" do
    let(:response) { responses(:jane_blue_team_adam_seat_response_1) }

    context "of the body" do
      before do
        response.update(body: body)
      end

      context "when the body is very long" do
        let(:body) { "a" * 65_537 }

        it "truncates the body" do
          expect(response.body).to eq("a" * 65_532 + "...")
        end
      end

      context "when the body is not very long" do
        let(:body) { "b" }

        it "updates the body" do
          expect(response.body).to eq("b")
        end
      end
    end
  end
end
