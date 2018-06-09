class TeamsController < ApplicationController
  before_action :set_tournament, only: %i[index new create]
  before_action :set_team, only: %i[edit update toggle destroy]

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
        format.js { flash.now[:notice] = 'Created' }
      else
        format.js { render action: 'new' }
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
        format.js { flash.now[:notice] = 'Saved' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @team.destroy
        format.js { flash.now[:notice] = 'Deleted' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def toggle
    respond_to do |format|
      @team.active = @team.active.to_i * -1 + 1
      if @team.save
        format.js { flash.now[:notice] = 'Saved' }
      else
        format.js do
          flash.now[:error] = 'Update failed'
          render action: 'toggle', status: :internal_server_error
        end
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
