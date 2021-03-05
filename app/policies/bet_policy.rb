class BetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    return true if user
  end

  def show?
    return true if user
  end

  def create?
    return true if user
  end

  def show?
    return true if user
  end

  def update?
    return true if user
  end

  def destroy?
    record.user == user
  end

  def claim_bets?
    true
  end
end
