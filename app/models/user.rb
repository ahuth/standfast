class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :trackable, :validatable

  belongs_to :account

  before_validation :create_account, on: :create
  before_destroy :ensure_account_has_users

  private

  def create_account
    if account.blank?
      self.account = Account.create!
    end
  end

  def ensure_account_has_users
    if account.users.count == 1
      errors.add(:base, "Cannot remove the only user on an account")
      throw :abort
    end
  end
end
