require "rails_helper"

RSpec.describe "Users", type: :request do
  let(:user) { create(:user, email: "user@gitlocker.com") }

  before { sign_in user }

  describe "GET show" do
    it "succeeds" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

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

  describe "PUT update" do
    let(:update_request) do
      put user_path(user), params: {
        user: {
          email: "foo@bar.com"
        }
      }
    end

    context "when invalid user" do
      it "raises pundit error" do
        other_user = create(:user)
        sign_out user
        sign_in other_user
        expect { update_request }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context "when valid user" do
      it "successfully updates user profile" do
        expect do
          update_request
        end.to change { user.reload.email }.from("user@gitlocker.com").to("foo@bar.com")
      end

      it "redirects to edit_user_path" do
        update_request
        expect(response).to redirect_to(edit_user_path(user))
      end
    end
  end
end
