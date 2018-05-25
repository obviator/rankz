# frozen_string_literal: true

class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.text :desc
      t.string :slug, null: false, index: { unique: true }
      t.date :start_date, null: false
      t.integer :active, default: 0

      t.timestamps
    end
  end
end
