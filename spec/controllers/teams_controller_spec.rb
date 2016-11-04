require 'rails_helper'

describe TeamsController, type: :controller do
  describe "#index" do
    def do_request
      get :index
    end

    context "when the user is not logged in" do
      before do
        expect(subject.current_user).to be_nil
      end

      it "redirects to the login page" do
        do_request
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when the user is logged in" do
      let(:user) { users(:jane) }

      it "is successful" do
        sign_in(user)
        do_request
        expect(response).to have_http_status(:success)
      end
    end
  end
end
