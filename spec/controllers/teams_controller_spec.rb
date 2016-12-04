require "rails_helper"
require "support/shared_examples/controllers"

describe TeamsController, type: :controller do
  let(:user) { users(:jane) }
  let(:owned_team) { teams(:jane_blue_team) }
  let(:non_owned_team) { teams(:bob_black_team) }

  describe "#index" do
    it_behaves_like "a protected index action"
  end

  describe "#show" do
    it_behaves_like "a protected show action" do
      let(:object_owned_by_user) { owned_team }
      let(:object_not_owned_by_user) { non_owned_team }
    end
  end

  describe "#new" do
    it_behaves_like "a protected new action", skip_ownership_check: true do
      let(:owner_request_params) { {} }
    end

    context "when the time_zone parameter is present" do
      def do_request
        get :new, params: { time_zone: "Berlin" }
      end

      it "works" do
        sign_in(user)
        do_request
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "#create" do
    let(:valid_team_params) { { name: "Purple", time_zone: "Pacific Time (US & Canada)" } }
    let(:invalid_team_params) { { name: "", time_zone: "Pacific Time (US & Canada)" } }

    it_behaves_like "a protected create action", skip_ownership_check: true do
      let(:model) { Team }
      let(:valid_owner_request_params) { { team: valid_team_params } }
      let(:invalid_owner_request_params) { { team: invalid_team_params } }
      let(:after_create_redirect_url) { teams_path }
    end
  end

  describe "#edit" do
    it_behaves_like "a protected edit action" do
      let(:owner_request_params) { { id: owned_team.id } }
      let(:non_owner_request_params) { { id: non_owned_team.id } }
    end
  end

  describe "update" do
    let(:valid_team_params) { { name: "Green", time_zone: "Pacific Time (US & Canada)" } }
    let(:invalid_team_params) { { name: "", time_zone: "Pacific Time (US & Canada)" } }

    it_behaves_like "a protected update action" do
      let(:model_updated?) { -> { owned_team.reload.name == "Green" } }
      let(:valid_owner_request_params) { { id: owned_team.id, team: valid_team_params } }
      let(:valid_non_owner_request_params) { { id: non_owned_team.id, team: valid_team_params } }
      let(:invalid_owner_request_params) { { id: owned_team.id, team: invalid_team_params } }
      let(:after_update_redirect_url) { team_path(owned_team) }
    end
  end

  describe "#destroy" do
    it_behaves_like "a protected destroy action" do
      let(:model) { Team }
      let(:owner_request_params) { { id: owned_team.id } }
      let(:non_owner_request_params) { { id: non_owned_team.id } }
      let(:after_destroy_redirect_url) { teams_path }
    end
  end
end
