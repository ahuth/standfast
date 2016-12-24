class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: [:edit, :update, :destroy]
  before_action :set_active_nav, only: [:index, :edit]

  def index
    @users = current_account.users
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User was succesfully updated"
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path
  end

  private

  def load_user
    @user = current_account.users.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_active_nav
    @active_nav = "users"
  end
end
