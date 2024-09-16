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

    return false if user&.purchased_products&.include?(record)

    user.blank? || record.user_id != user.id
  end

  def download_able?
    return false unless record.active?

    return false unless record.published?

    return false unless record.purchases.where(user_id: user&.id).any?

    user.blank? || record.user_id != user.id
  end

  def reviewable?
    return false unless record.active?

    return false unless record.published?

    return false if user.blank?

    return false if record.reviews.pluck(:user_id).include?(user.id)

    record.user_id != user.id
  end
end
