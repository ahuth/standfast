class Seat < ApplicationRecord
  belongs_to :team
  has_many :responses, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { scope: :team_id }
  validates :team, presence: true
end
