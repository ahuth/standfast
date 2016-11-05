require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    let(:user) { users(:jane) }

    before do
      expect(user).to be_valid
    end

    context "without an email" do
      before do
        user.email = nil
      end

      it "is invalid" do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq(["Email can't be blank"])
      end
    end

    context "with an email that already exists" do
      let(:bob) { users(:bob) }

      before do
        user.email = bob.email
      end

      it "is invalid" do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq(["Email has already been taken"])
      end
    end
  end
end
