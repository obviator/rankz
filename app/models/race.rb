# frozen_string_literal: true

class Race < ApplicationRecord
  belongs_to :tournament
  has_many :teams, dependent: :restrict_with_error

  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: { scope: :tournament }
  validates :tournament_id, presence: true

  def active?
    active&.positive?
  end

  def toggle
    self.active = if active.to_i.zero?
                    1
                  elsif locked?
                    1
                  else
                    0
                  end
    save
  end

  def locked?
    teams.present?
  end

end
