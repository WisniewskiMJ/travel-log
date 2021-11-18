require "rails_helper"

RSpec.describe EntryCreator, type: :model do
  describe "#call" do
    let(:user) { create(:user) }
    context "with valid params", :vcr do
      let(:params) { {location: "Dyszobaba", note: "Some note"} }
      let(:result) { EntryCreator.new(params, user).call }
      it "adds entry to database" do
        expect { EntryCreator.new(params, user).call }.to change { Entry.count }.by(1)
      end
      it "returns openstruct containing success boolean and entry" do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.created?).to be(true)
        expect(result[:payload]).to be_an_instance_of(Entry)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { {location: "", note: "Some note"} }
      let(:result) { EntryCreator.call(invalid_params, user) }
      it "does not add entry to database" do
        expect { EntryCreator.call(invalid_params, user) }.not_to change { Entry.count }
      end
      it "adds errors to entry" do
        expect(result.payload.errors.full_messages).not_to be_empty
      end
      it "returns openstruct containing failure boolean and entry" do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.created?).to be(false)
        expect(result[:payload]).to be_an_instance_of(Entry)
      end
    end
  end
end
