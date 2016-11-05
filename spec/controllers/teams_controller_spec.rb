require 'rails_helper'
require 'support/shared_examples/requires_login'

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
    def do_request
      get :show, params: { id: team.id }
    end

    it_behaves_like "it requires login" do
      let(:team) { teams(:jane_red_team) }
    end

    context "for a team that is not owned by the user" do
      let(:team) { teams(:bob_black_team) }

      before do
        expect(team.user_id).to_not eq(user.id)
      end

      it "is not successful" do
        sign_in(user)
        expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context "for a team that is owned by the user" do
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
