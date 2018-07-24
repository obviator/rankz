# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

system = User.create(username: 'system',
                     confirmed_at: Date.today,
                     password: ENV['system_password'],
                     email: ENV['system_email'])
system.add_role :admin

tournament = Tournament.create(name: 'default',
                               slug: 'default',
                               start_date: Date.today,
                               wincalc: 0,
                               losecalc: 0,
                               drawcalc: 0,
                               concedecalc: 0,
                               active: -1)

tournament.owner = system

races_list = [['Amazon', 1],
              ['Chaos', 1],
              ['Chaos Dwarf', 1],
              ['Chaos Pact', 1],
              ['Dark Elf', 1],
              ['Dwarf', 1],
              ['Elf', 1],
              ['Goblin', 1],
              ['Halfling', 1],
              ['High Elf', 1],
              ['Human', 1],
              ['Khemri', 1],
              ['Lizardmen', 1],
              ['Necromantic', 1],
              ['Norse', 1],
              ['Nurgle', 1],
              ['Ogre', 1],
              ['Orc', 1],
              ['Skaven', 1],
              ['Slann', 1],
              ['Undead', 1],
              ['Underworld', 1],
              ['Vampire', 1],
              ['Wood Elf', 1]]

races_list.each do |name, active|
  Race.create(name: name, active: active, tournament: tournament)
end
