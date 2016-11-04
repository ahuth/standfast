require 'rails_helper'

describe HomeController, type: :controller do
  describe "#index" do
    def do_request
      get :index
    end

    it "is successful" do
      do_request
      expect(response).to have_http_status(:success)
    end
  end
end
