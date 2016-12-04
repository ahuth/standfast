require "rails_helper"
require "support/shared_examples/controllers"

describe UsersController, type: :controller do
  let(:user) { users(:bob) }
  let(:user_on_account) { users(:bill) }
  let(:user_not_on_account) { users(:jane) }

  describe "#index" do
    it_behaves_like "a protected index action"
  end

  describe "#edit" do
    it_behaves_like "a protected edit action" do
      let(:owner_request_params) { { id: user_on_account.id } }
      let(:non_owner_request_params) { { id: user_not_on_account.id } }
    end
  end

  describe "update" do
    let(:valid_user_params) { { email: "green@example.com" } }
    let(:invalid_user_params) { { email: "" } }

    it_behaves_like "a protected update action" do
      let(:model_updated?) { -> { user_on_account.reload.email == "green@example.com" } }
      let(:valid_owner_request_params) { { id: user_on_account.id, user: valid_user_params } }
      let(:valid_non_owner_request_params) { { id: user_not_on_account.id, user: valid_user_params } }
      let(:invalid_owner_request_params) { { id: user_on_account.id, user: invalid_user_params } }
      let(:after_update_redirect_url) { users_path }
    end
  end

  describe "#destroy" do
    it_behaves_like "a protected destroy action" do
      let(:model) { User }
      let(:owner_request_params) { { id: user_on_account.id } }
      let(:non_owner_request_params) { { id: user_not_on_account.id } }
      let(:after_destroy_redirect_url) { users_path }
    end
  end
end
