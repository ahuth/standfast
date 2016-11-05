class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_team, only: [:show, :edit, :update]

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

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: "Team was succesfully updated"
    else
      render action: "edit"
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
