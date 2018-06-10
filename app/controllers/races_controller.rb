class RacesController < ApplicationController
  before_action :set_tournament, only: %i[index new create]
  before_action :set_race, only: %i[edit update toggle destroy]

  def index
    @races = @tournament.races.order(:name)
    @race = Race.new
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    @race.tournament = @tournament
    respond_to do |format|
      if @race.save
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
      if @race.update_attributes(race_params)
        format.js { flash.now[:notice] = 'Saved' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @race.destroy
        format.js { flash.now[:notice] = 'Deleted' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def toggle
    respond_to do |format|
      @race.active = @race.active.to_i * -1 + 1
      if @race.save
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

  def set_race
    @race = Race.find(params[:id])
  end

  def set_tournament
    @tournament = Tournament.friendly.find(params[:tournament_id])
  end

  def race_params
    params.require(:race).permit(:name, :active)
  end
end
