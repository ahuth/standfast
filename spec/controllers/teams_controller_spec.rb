require 'rails_helper'
require 'support/shared_examples/requires_login'

describe TeamsController, type: :controller do
  describe "#index" do
    let(:user) { users(:jane) }

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
end
