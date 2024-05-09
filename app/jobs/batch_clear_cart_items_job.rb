class BatchClearCartItemsJob < ApplicationJob
  queue_as :default

  def perform
    session_ids = CartItem.
                  where(user: nil).
                  where("created_at <= ?", 2.days.ago).
                  distinct(:session_id).
                  pluck(:session_id)

    session_ids.each do |session_id|
      ClearCartItemsJob.perform_now(session_id)
    end
  end
end
