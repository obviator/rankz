
class TeamsController < ApplicationController
  before_action :set_tournament, only: %i[index new create]

  def index
    @teams = @tournament.teams
    @team = Team.new
  end

  def new
    # @races = @tournament.races
    @team = Team.new
    @team.tournament = @tournament
    # respond_to do |format|
    #   format.html # new.html.erb
    #   format.js # new.js.erb
    # end
  end

  def create
    # @team = Team.new(team_params)
    # @team.tournament = @tournament
  end

  private

  def set_tournament
    @tournament = Tournament.friendly.find(params[:tournament_id])
  end

  def team_params
    params.require(:team).permit(:name, :race, :active)
  end
end
