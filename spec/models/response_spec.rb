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
      let(:response1) { responses(:jane_blue_team_ryan_seat_response_1) }
      let(:response2) { responses(:jane_blue_team_shirish_seat_response_1) }
      let(:response_ids) { [response1.id, response2.id] }
      let(:scoped_ids) { unscoped.unhandled.pluck(:id) }
      let(:unscoped) { Response.where(id: response_ids) }

      context "when no responses are handled" do
        before do
          expect(response1).to_not be_handled
          expect(response2).to_not be_handled
        end

        it "returns all responses" do
          expect(scoped_ids).to match_array(response_ids)
        end
      end

      context "when some responses are handled" do
        before do
          expect(response1).to_not be_handled
          response2.handled = true
          response2.save!
        end

        it "returns only the unhandled responses" do
          expect(scoped_ids).to match_array([response1.id])
        end
      end

      context "when all responses are handled" do
        before do
          response1.handled = true
          response1.save!
          response2.handled = true
          response2.save!
        end

        it "returns no responses" do
          expect(scoped_ids).to eq([])
        end
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
