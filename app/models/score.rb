# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :table, inverse_of: :scores
  belongs_to :team, inverse_of: :scores
  delegate :wincalc, :concedecalc, :losecalc, :drawcalc,
           to: :table,
           allow_nil: true
  delegate :user_is_to?, :user_is_ato?, to: :table
  validates :team_id, uniqueness: { scope: :table }
  validates :td, numericality: { only_integer: true,
                                 greater_than_or_equal_to: 0,
                                 less_than_or_equal_to: 32,
                                 allow_nil: true }
  validates :cas, numericality: { only_integer: true,
                                  greater_than_or_equal_to: 0,
                                  less_than_or_equal_to: 32,
                                  allow_nil: true }
  validates_presence_of :team
  validates_presence_of :table

  def score
    return 0 unless table.complete?
    calc_store
    add_functions
    calculator.evaluate(calc)
  end

  private

  def add_functions
    calculator.add_function(
      :limit, :numeric, ->(value, vmin, vmax) { [vmax, [vmin, value].max].min }
    )
    calculator.add_function(
      :is, :numeric, ->(statement) { statement ? 1 : 0 }
    )
  end

  def calc_store
    calculator.store(
      tf: td.to_i,
      ta: ta.to_i,
      tn: tn.to_i,
      cf: cas.to_i,
      ca: ca.to_i,
      cn: cn.to_i
    )
  end

  def calc
    if concede?
      concedecalc
    elsif td > ta || conceded_against?
      wincalc
    elsif td == ta
      drawcalc
    else
      losecalc
    end
  end

  def conceded_against?
    table.scores.where.not(id: id).first.concede?
  end

  def calculator
    @calculator ||= Dentaku::Calculator.new
  end

  def ta
    table.scores.where.not(id: id).sum(:td)
  end

  def tn
    td - ta
  end

  def ca
    table.scores.where.not(id: id).sum(:cas)
  end

  def cn
    cas - ca
  end
end
