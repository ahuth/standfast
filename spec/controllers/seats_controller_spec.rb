require 'rails_helper'
require 'support/shared_examples/controllers'

describe SeatsController, type: :controller do
  let(:user) { users(:bob) }

  describe "#new" do
    def do_request
      get :new, params: { team_id: team.id }
    end

    it_behaves_like "login is required" do
      let(:team) { teams(:bob_black_team) }
    end

    it_behaves_like "resource ownership is required" do
      let(:team) { teams(:jane_blue_team) }
      let(:resource_owner_id) { team.user_id }
    end

    context "when the seat belongs to the user" do
      let(:team) { teams(:bob_black_team) }

      before do
        expect(team.user_id).to eq(user.id)
      end

      it "is successful" do
        sign_in(user)
        do_request
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#edit" do
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

  describe "#update" do
    def do_request
      patch :update, params: { id: seat.id, seat: seat_params }
    end

    it_behaves_like "login is required" do
      let(:seat) { seats(:bob_pink_team_bill_seat) }
      let(:seat_params) { {} }
    end

    it_behaves_like "resource ownership is required" do
      let(:seat) { seats(:jane_red_team_iceman_seat) }
      let(:seat_params) { {} }
      let(:resource_owner_id) { seat.team.user_id }
    end

    context "when the seat belongs to the user" do
      let(:seat) { seats(:bob_pink_team_bill_seat) }

      before do
        expect(seat.team.user_id).to eq(user.id)
      end

      context "when sending valid params" do
        let(:seat_params) { { email: "aaa@example.com" } }

        it "redirects back to the team" do
          sign_in(user)
          do_request
          expect(response).to redirect_to(team_path(seat.team))
        end

        it "updates the model" do
          expect(seat.email).to_not eq("aaa@example.com")
          sign_in(user)
          do_request
          seat.reload
          expect(seat.email).to eq("aaa@example.com")
        end
      end

      context "when sending invalid params" do
        let(:seat_params) { { email: "" } }

        it "is successful" do
          sign_in(user)
          do_request
          expect(response).to have_http_status(:success)
        end

        it "does not update the model" do
          sign_in(user)
          do_request
          seat.reload
          expect(seat.email).to eq("bill@example.com")
        end
      end
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
        do_request
        expect(Seat.find_by(id: seat.id)).to be_nil
      end
    end
  end
end
