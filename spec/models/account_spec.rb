require "rails_helper"

describe Account, type: :model do
  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:teams).dependent(:destroy) }
  it { should have_many(:seats).through(:teams) }
end
