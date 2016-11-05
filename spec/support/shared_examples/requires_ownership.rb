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
