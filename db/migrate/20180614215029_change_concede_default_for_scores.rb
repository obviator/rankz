class ChangeConcedeDefaultForScores < ActiveRecord::Migration[5.2]
  def change
    Score.update_all(concede?: false)
    change_column_default :scores, :concede?, from: nil, to: false
  end
end
