class Team < ApplicationRecord
  belongs_to :account
  has_many :seats, dependent: :destroy
  has_many :responses, through: :seats

  validates :account, presence: true
  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { scope: :account_id }
  validate :time_zone_exists

  scope :with_unhandled_responses, -> { joins(:responses).merge(Response.unhandled).distinct }

  private

  def time_zone_exists
    if ActiveSupport::TimeZone[time_zone].blank?
      errors.add(:time_zone, "does not exist")
    end
  end
end
