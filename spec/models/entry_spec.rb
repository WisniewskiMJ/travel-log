require "rails_helper"

RSpec.describe Entry, type: :model do
  describe "default scope" do
    let(:user) { create(:user) }
    it "orders posts by creation date descending" do
      entry1 = create(:entry, user_id: user.id, created_at: 1.day.ago)
      entry2 = create(:entry, user_id: user.id, created_at: 2.days.ago)
      expect(Entry.all).to eq [entry1, entry2]
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:note) }
    it { is_expected.to validate_presence_of(:user_id) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end
end
