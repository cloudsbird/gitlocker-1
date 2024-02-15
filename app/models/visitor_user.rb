class VisitorUser
  def initialize(session_id)
    @session_id = session_id
  end

  def cart_items
    CartItem.where(session_id: @session_id)
  end
end
