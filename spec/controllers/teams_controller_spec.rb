require 'rails_helper'
require 'support/shared_examples/requires_login'
require 'support/shared_examples/requires_ownership'

describe TeamsController, type: :controller do
  let(:user) { users(:jane) }

  describe "#index" do
    def do_request
      get :index
    end

    it_behaves_like "it requires login"

    it "is successful" do
      sign_in(user)
      do_request
      expect(response).to have_http_status(:success)
    end
  end

  describe "#show" do
    let(:team) { teams(:jane_red_team) }

    def do_request
      get :show, params: { id: team.id }
    end

    it_behaves_like "it requires login" do
      let(:team) { teams(:jane_red_team) }
    end

    it_behaves_like "it requires resource ownership" do
      let(:team) { teams(:bob_black_team) }
      let(:resource_owner_id) { team.user_id }
    end

    it "is successful" do
      sign_in(user)
      do_request
      expect(response).to have_http_status(:success)
    end
  end
end
