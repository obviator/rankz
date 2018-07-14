class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user
    @user = user
    @record = record
  end

  def index?
    user.has_role?(:admin) || false
  end

  def show?
    user.has_role?(:admin) || scope.where(:id => record.id).exists?
  end

  def create?
    user.has_role?(:admin) || false
  end

  def new?
    create?
  end

  def update?
    user.has_role?(:admin) || false
  end

  def edit?
    update?
  end

  def destroy?
    user.has_role?(:admin) || false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, 'must be logged in' unless user
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
