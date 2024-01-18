require "rails_helper"

RSpec.describe "CompleteDeveloperRegistrations", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  pending do
    describe "GET index" do
    end

    describe "PUT update" do
    end
  end
end
