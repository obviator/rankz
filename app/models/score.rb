# frozen_string_literal: true

class Score < ApplicationRecord
  belongs_to :table
  belongs_to :team
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

  def score
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
      tf: team.tf.to_i,
      ta: team.ta.to_i,
      tn: team.tn.to_i,
      cf: team.cf.to_i,
      ca: team.ca.to_i,
      cn: team.cn.to_i
    )
  end

  def calc
    if concede?
      concedecalc
    elsif team.tf > team.ta || conceded_against?
      wincalc
    elsif team.tf == team.ta
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
end
