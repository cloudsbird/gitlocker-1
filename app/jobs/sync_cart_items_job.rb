class SyncCartItemsJob < ApplicationJob
  queue_as :default

  def perform(user_id:, session_id:)
    cart_items = CartItem.where(user: nil, session_id: session_id)
    cart_items.update_all(user_id: user_id, session_id: nil)
    User.reset_counters(user_id, :cart_items)
  end
end
