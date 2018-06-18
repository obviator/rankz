class RenameConcedeForScores < ActiveRecord::Migration[5.2]
  def change
    rename_column :scores, :concede?, :concede
  end
end
