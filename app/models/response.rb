class Response < ApplicationRecord
  belongs_to :seat

  validates :body, presence: true
end
