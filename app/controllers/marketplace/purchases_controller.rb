module Marketplace
class PurchasesController < ApplicationController
  def index
    @products = current_user&.purchased_products
  end

end
end
