require "rails_helper"

RSpec.describe EntriesController, type: :controller do
  let(:user) { create(:user) }

  describe "GET #index" do
    before do
      sign_in user
      get :index
    end
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "POST #create" do
    before do
      sign_in user
    end
    context "with valid params", :vcr do
      let(:valid_params) { {entry: {location: "Dyszobaba", note: "Some note"}} }
      it "creates a new entry" do
        expect {
          post :create, params: valid_params
        }.to change { Entry.count }.by(1)
      end
      it "displays a notice message" do
        post :create, params: valid_params
        expect(flash[:notice]).to be_present
      end
      it "redirects to the root path" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end
    context "with invalid params", :vcr do
      let(:invalid_params) { {entry: {location: nil, note: "Some note"}} }
      it "does not create a new entry" do
        expect {
          post :create, params: invalid_params
        }.to_not change { Entry.count }
      end
      it "displays an alert message" do
        post :create, params: invalid_params
        expect(flash[:alert]).to be_present
      end
      it "redirects to the root path" do
        post :create, params: invalid_params
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #show" do
    before do
      sign_in user
      @entry = create(:entry, user: user)
      get :show, params: {id: @entry.id}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the show template" do
      expect(response).to render_template("show")
    end
  end

  describe "GET #edit" do
    before do
      sign_in user
      @entry = create(:entry, user: user)
      get :edit, params: {id: @entry.id}
    end
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the edit template" do
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    before do
      sign_in user
      @entry = create(:entry, user: user)
    end
    context "with valid params" do
      let(:valid_params) { {location: "Długosiodło", note: "Some note"} }
      it "updates the entry" do
        patch :update, params: {id: @entry.id, entry: valid_params}
        expect(@entry.reload.location).to eq("Długosiodło")
      end
      it "displays a notice message" do
        patch :update, params: {id: @entry.id, entry: valid_params}
        expect(flash[:notice]).to be_present
      end
      it "redirects to the entry" do
        patch :update, params: {id: @entry.id, entry: valid_params}
        expect(response).to redirect_to(@entry)
      end
    end
    context "with invalid params" do
      let(:invalid_params) { {location: "", note: "Some note"} }
      it "does not update the entry" do
        patch :update, params: {id: @entry.id, entry: invalid_params}
        expect(@entry.reload.location).to_not eq("")
      end
      it "displays an alert message" do
        patch :update, params: {id: @entry.id, entry: invalid_params}
        expect(flash[:alert]).to be_present
      end
      it "renders the edit template" do
        patch :update, params: {id: @entry.id, entry: invalid_params}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in user
      @entry = create(:entry, user: user)
    end
    it "deletes the entry" do
      expect {
        delete :destroy, params: {id: @entry.id}
      }.to change { Entry.count }.by(-1)
    end
    it "displays a notice message" do
      delete :destroy, params: {id: @entry.id}
      expect(flash[:notice]).to be_present
    end
    it "redirects to the root path" do
      delete :destroy, params: {id: @entry.id}
      expect(response).to redirect_to(root_path)
    end
  end
end
