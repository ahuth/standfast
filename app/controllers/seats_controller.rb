class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_seat, only: [:edit]

  def edit
  end

  private

  def load_seat
    @seat = current_user.seats.find(params[:id])
  end
end
