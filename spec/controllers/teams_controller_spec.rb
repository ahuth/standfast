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
end
