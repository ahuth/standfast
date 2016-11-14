class Team < ApplicationRecord
  belongs_to :account
  has_many :seats, dependent: :destroy
  has_many :responses, through: :seats

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { scope: :account_id }
end
