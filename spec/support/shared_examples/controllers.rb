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

shared_examples "it requires resource ownership" do
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
