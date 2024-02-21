require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET edit" do
    context "when valid user" do
      it "succeeds" do
        get edit_user_path(user)
        expect(response).to have_http_status(:success)
      end
    end

    context "when trying to access another user's edit page" do
      it "raises pundit error" do
        other_user = create(:user)
        sign_out user
        sign_in other_user
        expect do
          get edit_user_path(user)
        end.to raise_error(Pundit::NotAuthorizedError)
      end
    end
  end
end
