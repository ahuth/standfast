require 'rails_helper'

describe HomeController, type: :controller do
  describe "#index" do
    def do_request
      get :index
    end

    it "returns http success" do
      do_request
      expect(response).to be_success
    end
  end
end
