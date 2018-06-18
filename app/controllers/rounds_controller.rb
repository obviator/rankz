# frozen_string_literal: true

class RoundsController < ApplicationController
  before_action :set_tournament, only: %i[index new create]
  before_action :set_round, only: %i[show edit update destroy]

  def index
    @rounds = Round.all
  end

  def show
    @tournament = @round.tournament
    @tables = @round.tables.order(:position)
  end

  def new
    @round = Round.new
  end

  def edit; end

  def create
    @round = Round.new
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
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
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
