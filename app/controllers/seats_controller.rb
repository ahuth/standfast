class SeatsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_seat, only: [:edit, :update, :destroy]
  before_action :load_team, only: [:new, :create]
  before_action :set_active_nav, only: [:new, :edit]

  def new
    @seat = Seat.new(team: @team)
  end

  def create
    @seat = Seat.new(seat_params)
    @seat.team = @team
    if @seat.save
      redirect_to team_path(@seat.team), notice: "Seat was succesfully created"
    else
      render action: "new"
    end
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
    @seat = current_account.seats.find(params[:id])
  end

  def load_team
    @team = current_account.teams.find(params[:team_id])
  end

  def seat_params
    params.require(:seat).permit(:name, :email)
  end

  def set_active_nav
    @active_nav = "teams"
  end
end
