class VisitorUser
  def initialize(session_id = nil)
    @session_id = session_id.to_s
  end

  def cart_items
    return CartItem.none if @session_id.blank?

    CartItem.where(session_id: @session_id)
  end

  def products_in_cart
    return Product.none if cart_items.none?

    product_ids = cart_items.pluck(:product_id)
    Product.where(id: product_ids)
  end
end
