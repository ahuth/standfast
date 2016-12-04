require "rails_helper"

describe User, type: :model do
  it { should belong_to(:account) }
  it { should validate_presence_of(:email) }

  describe "validations" do
    let(:user) { users(:jane) }

    before do
      expect(user).to be_valid
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

    context "without an account" do
      before do
        user.account = nil
      end

      it "is invalid" do
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to eq(["Account must exist"])
      end
    end
  end

  describe "creating" do
    before do
      user.save!
    end

    context "with an account" do
      let(:account) { accounts(:jane_account) }
      let(:user) { User.new(email: "shaw@example.com", account_id: account.id, password: "password", password_confirmation: "password") }

      it "keeps the provided account" do
        expect(user.account_id).to eq(account.id)
      end
    end

    context "without an account" do
      let(:user) { User.new(email: "john@example.com", password: "password", password_confirmation: "password") }

      it "creates a new account" do
        expect(user.account).to be_present
      end
    end
  end

  describe "destroying" do
    context "when more than one user is on the account" do
      let(:user) { users(:bob) }

      before do
        expect(user.account.users.count).to be > 1
        user.destroy
      end

      it "works" do
        expect(user).to be_destroyed
      end
    end

    context "when the user is the only one on the account" do
      let(:user) { users(:jane) }

      before do
        expect(user.account.users.count).to eq(1)
        user.destroy
      end

      it "does not work" do
        expect(user).to_not be_destroyed
      end

      it "adds a helpful error message" do
        expect(user.errors.full_messages).to eq(["Cannot remove the only user on an account"])
      end
    end
  end
end
