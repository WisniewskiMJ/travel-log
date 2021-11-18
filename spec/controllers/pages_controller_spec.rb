require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "GET #welcome" do
    context "when no user is logged in" do
      before do
        get :welcome
      end
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
      it "renders the welcome template" do
        expect(response).to render_template("welcome")
      end
    end

    context "when a user is logged in" do
      before do
        user = create(:user)
        sign_in user
        get :welcome
      end
      it "redirects to the entries page" do
        expect(response).to redirect_to(entries_url)
      end
    end
  end
end
