require 'rails_helper'
require 'support/shared_examples/controllers'

describe TeamsController, type: :controller do
  let(:user) { users(:jane) }

  describe "#index" do
    def do_request
      get :index
    end

    it_behaves_like "login is required"

    it "is successful" do
      sign_in(user)
      do_request
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    def do_request
      get :show, params: { id: team.id }
    end

    it_behaves_like "login is required" do
      let(:team) { teams(:jane_red_team) }
    end

    it_behaves_like "resource ownership is required" do
      let(:team) { teams(:bob_black_team) }
      let(:resource_owner_id) { team.user_id }
    end

    context "when the team belongs to the user" do
      let(:team) { teams(:jane_red_team) }

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

  describe "#new" do
    let(:user) { users(:jane) }

    def do_request
      get :new
    end

    it_behaves_like "login is required"

    it "is successful" do
      sign_in(user)
      do_request
      expect(response).to have_http_status(:success)
    end
  end

  describe "#create" do
    def do_request
      post :create, params: { team: team_params }
    end

    it_behaves_like "login is required" do
      let(:team_params) { {} }
    end

    context "when sending valid params" do
      let(:team_params) { { name: "Purple" } }

      it "redirects back to the index" do
        sign_in(user)
        do_request
        expect(response).to redirect_to(teams_path)
      end

      it "creates the model" do
        sign_in(user)
        expect { do_request }.to change { Team.count }.by(1)
        expect(Team.last.name).to eq("Purple")
      end
    end

    context "when sending invalid params" do
      let(:team_params) { { name: "" } }

      it "is successful" do
        sign_in(user)
        do_request
        expect(response).to have_http_status(:success)
      end

      it "does not create the model" do
        sign_in(user)
        expect { do_request }.to_not change { Team.count }
      end
    end
  end
end
