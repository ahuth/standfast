class Team < ApplicationRecord
  belongs_to :user
  has_many :seats, dependent: :destroy
  has_many :responses, through: :seats

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
