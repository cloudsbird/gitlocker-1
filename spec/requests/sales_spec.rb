require "rails_helper"

RSpec.describe "Sales", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET index" do
    it "succeeds" do
      get sales_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "succeeds" do
      product = create(:product, user: user)
      sale = create(:purchase, product: product)
      get sale_path(sale)
      expect(response).to have_http_status(:success)
    end
  end
end
