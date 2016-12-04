require "rails_helper"

describe HomeController, type: :controller do
  describe "#index" do
    def do_request
      get :index
    end

    context "when a user is not logged in" do
      before do
        expect(subject.current_user).to be_nil
      end

      it "is successful" do
        do_request
        expect(response).to have_http_status(:success)
      end
    end

    context "when a user is logged in" do
      let(:user) { users(:jane) }

      it "redirects to the teams page" do
        sign_in(user)
        do_request
        expect(response).to redirect_to(teams_path)
      end
    end
  end
end
