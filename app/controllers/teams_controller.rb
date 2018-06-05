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
    respond_to do |format|
      if @team.save
        format.js {flash.now[:notice] = 'Created'}
      else
        format.js {render action: 'new'}
      end
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @team.update_attributes(team_params)
        format.js {flash.now[:notice] = 'Saved'}
      else
        format.js {render action: 'edit'}
      end
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
