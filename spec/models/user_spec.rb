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
        expect(user.errors.full_messages).to eq(["Name can't be blank"])
      end
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
