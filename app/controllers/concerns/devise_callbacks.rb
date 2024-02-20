module DeviseCallbacks
  extend ActiveSupport::Concern

  included do
    after_action :sync_products, :sync_cart_items, only: :create
  end

  def sync_products
    return if resource.token.blank?

    SyncProductsJob.perform_later(resource.id)
  end

  def sync_cart_items
    return if session.id.to_s.blank?

    SyncCartItemsJob.perform_later(user_id: resource.id, session_id: session.id.to_s)
  end
end
