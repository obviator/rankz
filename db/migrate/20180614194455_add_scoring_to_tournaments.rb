class AddScoringToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :concedecalc, :string
  end
end
