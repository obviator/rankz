class ChangeActiveDefaultForRace < ActiveRecord::Migration[5.2]
  def change
    Race.update_all(active: 1)
    change_column_default :races, :active, from: nil, to: 1
  end
end

