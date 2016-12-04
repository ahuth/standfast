require "rails_helper"
require "support/shared_examples/controllers"

describe SeatsController, type: :controller do
  let(:user) { users(:bob) }
  let(:owned_seat) { seats(:bob_pink_team_bill_seat) }
  let(:non_owned_seat) { seats(:jane_red_team_iceman_seat) }

  describe "#new" do
    it_behaves_like "a protected new action" do
      let(:owner_request_params) { { team_id: owned_seat.team_id } }
      let(:non_owner_request_params) { { team_id: non_owned_seat.team_id } }
    end
  end

  describe "#create" do
    let(:valid_seat_params) { { name: "Buzz", email: "buzz@example.com" } }
    let(:invalid_seat_params) { { email: "buzz@example.com" } }

    it_behaves_like "a protected create action" do
      let(:model) { Seat }
      let(:valid_owner_request_params) { { team_id: owned_seat.team_id, seat: valid_seat_params } }
      let(:valid_non_owner_request_params) { { team_id: non_owned_seat.team_id, seat: valid_seat_params } }
      let(:invalid_owner_request_params) { { team_id: owned_seat.team_id, seat: invalid_seat_params } }
      let(:after_create_redirect_url) { team_path(teams(:bob_pink_team)) }
    end
  end

  describe "#edit" do
    it_behaves_like "a protected edit action" do
      let(:owner_request_params) { { id: owned_seat.id } }
      let(:non_owner_request_params) { { id: non_owned_seat.id } }
    end
  end

  describe "#update" do
    let(:valid_seat_params) { { email: "aaa@example.com" } }
    let(:invalid_seat_params) { { email: "" } }

    it_behaves_like "a protected update action" do
      let(:model_updated?) { -> { owned_seat.reload.email == "aaa@example.com" } }
      let(:valid_owner_request_params) { { id: owned_seat.id, seat: valid_seat_params } }
      let(:valid_non_owner_request_params) { { id: non_owned_seat.id, seat: valid_seat_params } }
      let(:invalid_owner_request_params) { { id: owned_seat.id, seat: invalid_seat_params } }
      let(:after_update_redirect_url) { team_path(owned_seat.team) }
    end
  end

  describe "#destroy" do
    it_behaves_like "a protected destroy action" do
      let(:model) { Seat }
      let(:owner_request_params) { { id: owned_seat.id } }
      let(:non_owner_request_params) { { id: non_owned_seat.id } }
      let(:after_destroy_redirect_url) { team_path(owned_seat.team) }
    end
  end
end
