require "rails_helper"

RSpec.describe EntryTemperatureSetter, type: :model do
  context "with valid coordinates", :vcr do
    let(:entry) { Entry.new(location: "Długosiodło", latitude: 52.759577, longitude: 21.5929004, temperature: nil) }
    let(:result) { EntryTemperatureSetter.new(entry).call }
    it "sets entry temperature to location temperature" do
      expect(result.payload.temperature).not_to be(nil)
    end
    it "returns openstruct containing success boolean and entry" do
      expect(result).to be_an_instance_of(OpenStruct)
      expect(result.successfull?).to be(true)
      expect(result.payload).to be_an_instance_of(Entry)
    end
  end

  context "with invalid coordinates", :vcr do
    let(:entry) { Entry.new(location: "Długosiodło", latitude: 500, longitude: 500, temperature: nil) }
    let(:result) { EntryTemperatureSetter.new(entry).call }
    it "does not set entry temperature" do
      expect(result.payload.temperature).to be(nil)
    end
    it "adds errors containing invalid result message to entry" do
      expect(result.payload.errors.full_messages).not_to be_empty
      expect(result.payload.errors.full_messages).to include("No weather report for given location")
    end
    it "returns openstruct containing failure boolean and entry" do
      expect(result).to be_an_instance_of(OpenStruct)
      expect(result.successfull?).to be(false)
      expect(result.payload).to be_an_instance_of(Entry)
    end
  end
end
