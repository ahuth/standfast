class Account < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :seats, through: :teams
end
