shared_examples "it requires login" do
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
