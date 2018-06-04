class TeamsController < ApplicationController
  before_action :set_tournament, only: %i[index new create]
  before_action :set_team, only: %i[edit update]

  def index
    @teams = @tournament.teams.order(:created_at)
    @team = Team.new
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.tournament = @tournament
    @team.save
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def update
    @team.update_attributes!(team_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def set_tournament
    @tournament = Tournament.friendly.find(params[:tournament_id])
  end

  def team_params
    params.require(:team).permit(:name, :race_id, :active)
  end
end
