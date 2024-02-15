class VisitorUser
  def initialize(session_id = nil)
    @session_id = session_id.to_s
  end

  def cart_items
    return CartItem.none if @session_id.blank?

    CartItem.where(session_id: @session_id)
  end
end
