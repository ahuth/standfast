require 'rails_helper'
require 'support/shared_examples/controllers'

describe SeatsController, type: :controller do
  describe "#edit" do
    let(:user) { users(:bob) }

    def do_request
      get :edit, params: { id: seat.id }
    end

    it_behaves_like "login is required" do
      let(:seat) { seats(:bob_pink_team_bill_seat) }
    end

    it_behaves_like "resource ownership is required" do
      let(:seat) { seats(:jane_red_team_iceman_seat) }
      let(:resource_owner_id) { seat.team.user_id }
    end

    context "when the seat belongs to the user" do
      let(:seat) { seats(:bob_pink_team_bill_seat) }

      before do
        expect(seat.team.user_id).to eq(user.id)
      end

      it "is successful" do
        sign_in(user)
        do_request
        expect(response).to have_http_status(:success)
      end
    end
  end
end
