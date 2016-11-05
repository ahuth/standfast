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
    def do_request
      post :create, params: { team_id: team.id, seat: seat_params }
    end

    it_behaves_like "login is required" do
      let(:team) { teams(:bob_pink_team) }
      let(:seat_params) { {} }
    end

    it_behaves_like "resource ownership is required" do
      let(:team) { teams(:jane_red_team) }
      let(:seat_params) { {} }
      let(:resource_owner_id) { team.user_id }
    end

    context "when the team belongs to the user" do
      let(:team) { teams(:bob_pink_team) }

      before do
        expect(team.user_id).to eq(user.id)
      end

      context "when sending valid params" do
        let(:seat_params) { { name: "Buzz", email: "buzz@example.com" } }

        it "redirects back to the team" do
          sign_in(user)
          do_request
          expect(response).to redirect_to(team_path(team))
        end

        it "creates the model" do
          sign_in(user)
          expect { do_request }.to change { Seat.count }.by(1)
          expect(Seat.last.email).to eq("buzz@example.com")
        end
      end

      context "when sending invalid params" do
        let(:seat_params) { { email: "buzz@example.com" } }

        it "is successful" do
          sign_in(user)
          do_request
          expect(response).to have_http_status(:success)
        end

        it "does not create the model" do
          sign_in(user)
          expect { do_request }.to_not change { Seat.count }
        end
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
          expect { do_request }.to change { seat.reload.email }.to("aaa@example.com")
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
          expect { do_request }.to_not change { seat.reload.email }
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
        expect { do_request }.to change { Seat.count }.by(-1)
      end
    end
  end
end
