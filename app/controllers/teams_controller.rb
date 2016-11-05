class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_team, only: [:show]

  def index
    @teams = current_user.teams
  end

  def show
  end

  private

  def load_team
    @team = current_user.teams.find(params[:id])
  end
end
