class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  belongs_to :account

  before_validation :create_account, on: :create

  private

  def create_account
    if account.blank?
      self.account = Account.create!
    end
  end
end
