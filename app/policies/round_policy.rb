# frozen_string_literal: true

class RoundPolicy < ApplicationPolicy
  def destroy?
    user.has_role?(:owner, record) || super
  end

  def create?
    user.has_role?(:owner, record) || super
  end

  def redraw?
    create?
  end
end
