class TournamentPolicy < ApplicationPolicy

  def update?
    user.has_role?(:to, record) || super
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
