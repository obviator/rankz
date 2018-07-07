class AddTiebreakerDataToTournament < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :tiebreaker, :text
  end
end
