class FundsController < ApplicationController
  def index
    @funds = current_user.total_sales_amount_in_dollars
  end
end
