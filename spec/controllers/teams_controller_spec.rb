require 'rails_helper'
require 'support/shared_examples/controllers'

describe TeamsController, type: :controller do
  let(:user) { users(:jane) }

  describe "#index" do
    it_behaves_like "a protected index action"
  end

  describe "#show" do
    it_behaves_like "a protected show action" do
      let(:object_owned_by_user) { teams(:jane_red_team) }
      let(:object_not_owned_by_user) { teams(:bob_pink_team) }
    end
  end

  describe "#new" do
    it_behaves_like "a protected new action", skip_ownership_check: true do
      let(:owner_request_params) { {} }
    end
  end

  describe "#create" do
    it_behaves_like "a protected create action", skip_ownership_check: true do
      let(:model) { Team }
      let(:valid_owner_request_params) { { team: { name: "Purple" } } }
      let(:invalid_owner_request_params) { { team: { name: "" } } }
      let(:after_create_redirect_url) { teams_path }
    end
  end

  describe "#edit" do
    it_behaves_like "a protected edit action" do
      let(:owner_request_params) { { id: teams(:jane_blue_team).id } }
      let(:non_owner_request_params) { { id: teams(:bob_black_team).id } }
    end
  end

  describe "update" do
    def do_request
      patch :update, params: { id: team.id, team: team_params }
    end

    it_behaves_like "login is required" do
      let(:team) { teams(:jane_blue_team) }
      let(:team_params) { {} }
    end

    it_behaves_like "resource ownership is required" do
      let(:team) { teams(:bob_black_team) }
      let(:team_params) { {} }
      let(:resource_owner_id) { team.user_id }
    end

    context "when the team belongs to the user" do
      let(:team) { teams(:jane_blue_team) }

      before do
        expect(team.user_id).to eq(user.id)
      end

      context "when sending valid params" do
        let(:team_params) { { name: "Green" } }

        it "redirects to the new team" do
          sign_in(user)
          do_request
          expect(response).to redirect_to(Team.last)
        end

        it "updates the model" do
          expect(team.name).to_not eq("Green")
          sign_in(user)
          expect { do_request }.to change { team.reload.name }.to("Green")
        end
      end

      context "when sending invalid params" do
        let(:team_params) { { name: "" } }

        it "is successful" do
          sign_in(user)
          do_request
          expect(response).to have_http_status(:success)
        end

        it "does not update the model" do
          sign_in(user)
          do_request
          expect { do_request }.to_not change { team.reload.name }
        end
      end
    end
  end

  describe "#destroy" do
    def do_request
      delete :destroy, params: { id: team.id }
    end

    it_behaves_like "login is required" do
      let(:team) { teams(:jane_blue_team) }
      let(:team_params) { {} }
    end

    it_behaves_like "resource ownership is required" do
      let(:team) { teams(:bob_black_team) }
      let(:team_params) { {} }
      let(:resource_owner_id) { team.user_id }
    end

    context "when the team belongs to the user" do
      let(:team) { teams(:jane_blue_team) }

      before do
        expect(team.user_id).to eq(user.id)
      end

      it "redirects to the teams index" do
        sign_in(user)
        do_request
        expect(response).to redirect_to(teams_path)
      end

      it "destroys the model" do
        sign_in(user)
        expect { do_request }.to change { Team.count }.by(-1)
      end
    end
  end
end
