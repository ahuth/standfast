class Seat < ApplicationRecord
  belongs_to :team

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
end
