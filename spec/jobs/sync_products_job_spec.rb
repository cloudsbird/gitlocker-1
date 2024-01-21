require "rails_helper"

RSpec.describe SyncProductsJob, type: :job do
  let(:user) { create(:user, token: SecureRandom.urlsafe_base64) }

  before do
    allow_any_instance_of(described_class).to receive(:repositories).and_return(
      [
        double(:repository, name: "product1", description: "123", html_url: "https://www.github.com/1"),
        double(:repository, name: "product2", description: "123", html_url: "https://www.github.com/2")
      ]
    )
  end

  it "imports 2 products" do
    expect { described_class.perform_now(user.id) }.to change { Product.count }.from(0).to(2)
  end

  it "syncs users" do
    expect { described_class.perform_now(user.id) }.to change { user.reload.synced? }.from(false).to(true)
  end

  it "sets syncing to false post processing" do
    user.update! syncing: true
    expect { described_class.perform_now(user.id) }.to change { user.reload.syncing? }.from(true).to(false)
  end
end
