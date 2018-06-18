class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :table, foreign_key: true
      t.references :team, foreign_key: true
      t.integer :td
      t.integer :cas
      t.boolean :concede?

      t.timestamps
    end
  end
end
