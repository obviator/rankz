# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :tournament
  belongs_to :race
  has_many :scores

  resourcify

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: { scope: :tournament }
  validates :tournament_id, presence: true
  # validates :race_id, presence: true

  def tf
    scores.sum(:td)
  end

  def ta
    ta = 0
    scores.each do |score|
      ta += score.table.scores.where.not(team_id: id).sum(:td)
    end
    ta
  end

  def tn
    tf - ta
  end

  def cf
    scores.sum(:cas)
  end

  def ca
    ca = 0
    scores.each do |score|
      ca += score.table.scores.where.not(team_id: id).sum(:cas)
    end
    ca
  end

  def cn
    cf - ca
  end

  def active?
    active&.positive?
  end

  def toggle
    self.active = if active.to_i.zero?
                    1
                  else
                    0
                  end
    save
  end
end
