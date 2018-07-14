class TournamentsController < ApplicationController
  include Pundit
  before_action :set_tournament, only: %i[show edit update destroy]
  after_action :verify_authorized, except: %i[index]

  def index
    @tournaments = Tournament.list
  end

  def show;
    authorize @tournament
  end

  def new
    @tournament = Tournament.new
    authorize @tournament
  end

  def edit
    authorize @tournament
  end

  def create
    @tournament = Tournament.new(tournament_params)
    authorize @tournament

    if @tournament.save
      current_user.add_role :to, @tournament
      redirect_to @tournament, notice: 'Tournament was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @tournament
    if @tournament.update(tournament_params)
      redirect_to edit_tournament_url(@tournament),
                  notice: 'Tournament updated'
    else
      render :edit
    end
  end

  def destroy
    authorize @tournament
    @tournament.destroy
    redirect_to tournaments_url, notice: 'Tournament was successfully destroyed.'
  end

  private

  def set_tournament
    @tournament = Tournament.friendly.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(:name,
                                       :desc,
                                       :slug,
                                       :start_date,
                                       :end_date,
                                       :active,
                                       :wincalc,
                                       :drawcalc,
                                       :losecalc,
                                       :concedecalc,
                                       tiebreaker: [])
  end
end
