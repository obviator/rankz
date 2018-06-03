class CreateRaces < ActiveRecord::Migration[5.2]
  def change
    create_table :races do |t|
      t.string :name
      t.references :tournament, foreign_key: true
      t.integer :active

      t.timestamps
    end
    add_index :races, [:name, :tournament_id], unique: true
  end
end
