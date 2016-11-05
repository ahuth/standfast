class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_seat, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @seat.update(seat_params)
      redirect_to team_path(@seat.team), notice: "Seat was succesfully updated"
    else
      render action: "edit"
    end
  end

  def destroy
    @seat.destroy!
    redirect_to team_path(@seat.team)
  end

  private

  def load_seat
    @seat = current_user.seats.find(params[:id])
  end

  def seat_params
    params.require(:seat).permit(:email)
  end
end
