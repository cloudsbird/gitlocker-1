class RefundsController < ApplicationController
  def new
    @refund = Refund.new
  end

  def create
    @refund = Refund.new(refund_params)
    @refund.product = Product.find(params[:refund][:product_id]) if params[:refund][:product_id].present?
    @refund.stripe_transaction_screenshot = params[:refund][:stripe_transaction_screenshot] if params[:refund][:stripe_transaction_screenshot].present?

    if @refund.save!
      RefundMailer.notify_admin(@refund, current_user).deliver_now
      redirect_to marketplace_root_path, notice: 'Refund request submitted successfully.'
    else
      render :new
    end
  end

  private

  def refund_params
    params.require(:refund).permit(:description, :stripe_transaction_screenshot, :product_id)
  end
end
