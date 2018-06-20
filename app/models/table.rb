# frozen_string_literal: true

class Table < ApplicationRecord
  belongs_to :round, inverse_of: :tables
  has_many :scores, dependent: :destroy, inverse_of: :table
  accepts_nested_attributes_for :scores
  has_many :teams, through: :scores
  delegate :wincalc, :concedecalc, :losecalc, :drawcalc, to: :round, allow_nil: true
  delegate :user_is_to?, :user_is_ato?, to: :round
  acts_as_list scope: :round

  validates_presence_of :round

  def complete?
    scores.each do |score|
      return false if score.td.nil? || score.cas.nil?
    end
    true
  end
end

