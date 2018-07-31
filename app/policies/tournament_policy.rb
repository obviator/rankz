class TournamentPolicy < ApplicationPolicy

  def update?
    user.has_role?(:owner, record) || super
  end

  def create?
    user.has_role?(:coach, record) || super
  end

  def tiebreakers_edit?
    create?
  end

  def tiebreakers_update?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
