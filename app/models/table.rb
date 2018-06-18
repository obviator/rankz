# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :round
  has_many :scores
  accepts_nested_attributes_for :scores
  has_many :teams, through: :scores
  delegate :wincalc, :concedecalc, :losecalc, :drawcalc, to: :round, allow_nil: true
  delegate :user_is_to?, :user_is_ato?, to: :round
  acts_as_list scope: :round

  def complete?
    scores.each do |score|
      return false if score.td.nil? || score.cas.nil?
    end
    true
  end
end

