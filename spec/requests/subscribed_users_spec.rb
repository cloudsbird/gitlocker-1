require "rails_helper"

RSpec.describe "SubscribedUsers", type: :request do
  let(:make_request!) do
    post subscribed_users_path, params: {
      email: "foo@bar.com"
    }, headers: { "ACCEPT": "application/json" }
  end

  describe "POST create" do
    it "succeeds" do
      make_request!
      expect(response).to have_http_status(:created)
    end

    it "creates a new subscribed user" do
      expect { make_request! }.to change { SubscribedUser.count }.from(0).to(1)
    end
  end
end
