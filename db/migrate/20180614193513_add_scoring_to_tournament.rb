class AddScoringToTournament < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :wincalc, :string
    add_column :tournaments, :losecalc, :string
    add_column :tournaments, :drawcalc, :string
  end
end
