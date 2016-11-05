class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_seat, only: [:edit, :update, :destroy]
  before_action :load_team, only: [:new]

  def new
    @seat = Seat.new(team: @team)
  end

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

  def load_team
    @team = current_user.teams.find(params[:team_id])
  end

  def seat_params
    params.require(:seat).permit(:name, :email)
  end
end
