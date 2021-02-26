class EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def destroy?
    record.user == user
  end

  def my_stats?
    true
  end
end
