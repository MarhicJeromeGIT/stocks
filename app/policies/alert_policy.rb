class AlertPolicy < ApplicationPolicy
  def create?
    true # anybody can create an alert at all times
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end
end
