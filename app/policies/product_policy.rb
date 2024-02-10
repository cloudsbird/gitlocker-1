class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def edit?
    return false if user.blank?

    record.user_id == user.id
  end

  def purchasable?
    return false unless record.active?

    return false unless record.published?

    user.blank? || record.user_id != user.id
  end

  def reviewable?
    return false unless record.active?

    return false unless record.published?

    user.blank? || record.user_id != user.id
  end
end
