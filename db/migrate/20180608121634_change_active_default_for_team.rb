class ChangeActiveDefaultForTeam < ActiveRecord::Migration[5.2]
  def change
    Team.update_all(active: 1)
    change_column_default :teams, :active, from: nil, to: 1
  end
end
