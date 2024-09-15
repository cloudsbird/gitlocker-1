module Marketplace
class PurchasesController < ApplicationController
  def index
    @products = current_user&.purchased_products.page(params[:page]).per(50)
  end

end
end
