require 'rails_helper'
require 'support/shared_examples/controllers'

describe SeatsController, type: :controller do
  let(:user) { users(:bob) }

  describe "#new" do
    it_behaves_like "a protected new action" do
      let(:owner_request_params) { { team_id: teams(:bob_black_team).id } }
      let(:non_owner_request_params) { { team_id: teams(:jane_red_team).id } }
    end
  end

  describe "#create" do
    it_behaves_like "a protected create action" do
      let(:model) { Seat }
      let(:valid_owner_request_params) { { team_id: teams(:bob_pink_team).id, seat: { name: "Buzz", email: "buzz@example.com" } } }
      let(:valid_non_owner_request_params) { { team_id: teams(:jane_red_team).id, seat: { name: "Buzz", email: "buzz@example.com" } } }
      let(:invalid_owner_request_params) { { team_id: teams(:bob_pink_team).id, seat: { email: "buzz@example.com" } } }
      let(:after_create_redirect_url) { team_path(teams(:bob_pink_team)) }
    end
  end

  describe "#edit" do
    it_behaves_like "a protected edit action" do
      let(:owner_request_params) { { id: seats(:bob_pink_team_bill_seat).id } }
      let(:non_owner_request_params) { { id: seats(:jane_red_team_iceman_seat).id } }
    end
  end

  describe "#update" do
    let(:owned_seat) { seats(:bob_pink_team_bill_seat) }
    let(:non_owned_seat) { seats(:jane_red_team_iceman_seat) }

    it_behaves_like "a protected update action" do
      let(:model_updated?) { -> { owned_seat.reload.email == "aaa@example.com" } }
      let(:valid_owner_request_params) { { id: owned_seat.id, seat: { email: "aaa@example.com" } } }
      let(:valid_non_owner_request_params) { { id: non_owned_seat.id, seat: { email: "aaa@example.com" } } }
      let(:invalid_owner_request_params) { { id: owned_seat.id, seat: { email: "" } } }
      let(:after_update_redirect_url) { team_path(owned_seat.team) }
    end
  end

  describe "#destroy" do
    def do_request
      delete :destroy, params: { id: seat.id }
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

      it "redirects back to the team" do
        sign_in(user)
        do_request
        expect(response).to redirect_to(team_path(seat.team))
      end

      it "destroys the model" do
        sign_in(user)
        expect { do_request }.to change { Seat.count }.by(-1)
      end
    end
  end
end
