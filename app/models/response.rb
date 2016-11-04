class Response < ApplicationRecord
  belongs_to :seat

  validates :body, presence: true

  scope :unhandled, -> { where(handled: false) }
end
