require 'rails_helper'

describe User, type: :model do
  fixtures :users

  describe "validations" do
    let(:user) { users(:jane) }

    before do
      expect(user).to be_valid
    end

    context "without a name" do
      before do
        user.name = nil
      end

      it "is invalid" do
        expect(user).to_not be_valid
      end
    end

    context "without an email" do
      before do
        user.email = nil
      end

      it "is invalid" do
        expect(user).to_not be_valid
      end
    end

    context "without a password" do
      before do
        user.encrypted_password = nil
      end

      it "is invalid" do
        expect(user).to_not be_valid
      end
    end
  end
end
