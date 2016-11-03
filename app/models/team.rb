class Team < ApplicationRecord
  belongs_to :user
  has_many :seats, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
