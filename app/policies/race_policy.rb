class RacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
      true
  end

  def update?
    true
  end

  def destroy?
    true
  end

  def race_dashboard?
    true
  end

end
