require "rails_helper"

RSpec.describe SyncCartItemsJob, type: :job do
  let(:session_id) { SecureRandom.uuid }
  let(:user) { create(:user) }
  let(:cart_item) { create(:cart_item, user: nil, session_id: session_id) }

  it "syncs up user-less cart items with the user" do
    described_class.perform_now(user_id: user.id, session_id: cart_item.session_id)
    cart_item.reload
    expect(cart_item.session_id).to be nil
    expect(cart_item.user_id).to eq user.id
  end
end
