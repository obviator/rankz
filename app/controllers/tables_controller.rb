# frozen_string_literal: true

class TablesController < ApplicationController
  before_action :set_tournament, only: %i[index]
  before_action :set_table, only: %i[edit reset update]

  def edit
    respond_to do |format|
      format.js
    end
  end

  def update
    respond_to do |format|
      if @table.update_attributes(table_params)
        format.js { flash.now[:notice] = 'Saved' }
      else
        format.js { render action: 'edit' }
      end
    end
  end

  def reset
    @table.scores.each do |score|
      score.td = nil
      score.cas = nil
      score.concede = false
      score.save
    end
    respond_to do |format|
      format.js { flash.now[:notice] = 'Reset' }
    end

  end

  private

  def set_table
    @table = Table.find(params[:id])
  end

  def set_tournament
    @tournament = Tournament.friendly.find(params[:tournament_id])
  end

  def table_params
    params.require(:table).permit(scores_attributes: %i[id td cas concede])
  end
end
