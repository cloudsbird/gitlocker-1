class ClearCartItemsJob < ApplicationJob
  queue_as :default

  def perform(session_id)
    CartItem.where(user: nil, session_id: session_id).delete_all
  end
end
