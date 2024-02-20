require "rails_helper"

RSpec.describe ClearCartItemsJob, type: :job do
  let(:session_id) { SecureRandom.uuid }
  let!(:cart_items) { create_list(:cart_item, 3, user: nil, session_id: session_id) }

  it "deletes cart_items" do
    expect do
      described_class.perform_now(session_id)
    end.to change { CartItem.count }.from(3).to(0)
  end
end
