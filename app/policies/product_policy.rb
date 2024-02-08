class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def edit?
    record.user_id == user.id
  end

  def purchasable?
    record.user_id != user.id
  end
end
