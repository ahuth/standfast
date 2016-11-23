class Response < ApplicationRecord
  MAX_BODY_LENGTH = 65_535

  belongs_to :seat

  validates :seat, presence: true
  validates :body, presence: true

  scope :handled, -> { where(handled: true) }
  scope :unhandled, -> { where(handled: false) }

  before_save :truncate_body, if: :body_changed?

  private

  def truncate_body
    if body.length > MAX_BODY_LENGTH
      self.body = body.truncate(MAX_BODY_LENGTH)
    end
  end
end
