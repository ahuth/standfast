require 'rails_helper'

describe Account, type: :model do
  let(:account) { accounts(:jane_account) }

  it "exists" do
    expect(account).to be_valid
  end
end
