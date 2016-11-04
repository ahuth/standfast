class Seat < ApplicationRecord
  belongs_to :team
  has_many :responses, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { scope: :team_id }
end
