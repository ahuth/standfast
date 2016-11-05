class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_team, only: [:show]

  def index
    @teams = current_user.teams
  end

  def show
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if @team.save
      redirect_to teams_path, notice: "Team was succesfully created"
    else
      render action: "new"
    end
  end

  private

  def load_team
    @team = current_user.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
