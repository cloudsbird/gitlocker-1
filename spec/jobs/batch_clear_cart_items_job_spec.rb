require "rails_helper"

RSpec.describe BatchClearCartItemsJob, type: :job do
  let(:session_id) { SecureRandom.uuid }
  let(:user) { create(:user) }
  let!(:cart_items_without_product) do
    create_list(:cart_item, 3, user: nil, session_id: session_id, created_at: 3.days.ago)
  end
  let!(:cart_items_with_product) { create_list(:cart_item, 2, user: user, created_at: 3.days.ago) }

  it "queues up one job" do
    allow(ClearCartItemsJob).to receive(:perform_later).and_return(true)
    described_class.perform_now
    expect(ClearCartItemsJob).to have_received(:perform_later).with(session_id).once
  end
end
