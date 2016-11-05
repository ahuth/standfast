shared_examples "login is required" do
  context "when a user is not logged in" do
    before do
      expect(subject.current_user).to be_nil
    end

    it "redirects to the login page" do
      do_request
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

shared_examples "resource ownership is required" do
  context "for a resource that is not owned by the user" do
    before do
      expect(resource_owner_id).to_not eq(user.id)
    end

    it "is not successful" do
      sign_in(user)
      expect { do_request }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end

shared_examples "a protected index action" do
  context "when a user is not signed in" do
    before do
      expect(subject.current_user).to be_nil
      get :index
    end

    it "redirects to the login page" do
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "when a user is signed in" do
    before do
      sign_in(user)
      get :index
    end

    it "is successful" do
      expect(response).to have_http_status(:success)
    end
  end
end
