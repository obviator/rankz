# frozen_string_literal: true

class RoundsController < ApplicationController
  include Pundit
  before_action :set_tournament, only: %i[index new create]
  before_action :set_round, only: %i[show edit update destroy redraw]
  after_action :verify_authorized, except: %i[index show]

  def index
    @rounds = Round.all
  end

  def show
    @tournament = @round.tournament
    @tables = @round.tables.order(:position)
  end

  def new
    @round = Round.new
    authorize @round
  end

  def edit; end

  def create
    @round = Round.new
    authorize @round
    @round.tournament = @tournament

    respond_to do |format|
      if @round.save
        format.js { flash[:notice] = 'Created' }
      else
        format.js { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to @round, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @round
    url = @round.higher_item ? round_url(@round.higher_item) : tournament_teams_url(@round.tournament)
    if @round.destroy
      redirect_to url, notice: 'Round deleted'
    else
      flash[:error] = 'Delete failed'
      redirect_to round_url(@round)
    end

  end

  def redraw
    authorize @round
    @tournament = @round.tournament
    @tables = @round.tables.order(:position)
    @round.redraw
    respond_to do |format|
      if @round.save
        format.js { flash.now[:notice] = 'Redrawn' }
      else
        format.js { render action: 'show' }
      end
    end
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end

  # def round_params
  #   params.require(:round).permit(:position, :tournament_id)
  # end

  def set_tournament
    @tournament = Tournament.friendly.find(params[:tournament_id])
  end
end
