require 'rails_helper'

describe Seat, type: :model do
  it { should belong_to(:team) }
  it { should have_many(:responses).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_most(255) }
  it { should validate_presence_of(:email) }
  it { should validate_length_of(:email).is_at_most(255) }
  it { should validate_uniqueness_of(:email).scoped_to(:team_id) }
end
