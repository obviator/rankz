class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.references :tournament, foreign_key: true
      t.references :race, foreign_key: true
      t.integer :active

      t.timestamps
    end
    add_index :teams, [:name, :tournament_id], unique: true
  end
end
