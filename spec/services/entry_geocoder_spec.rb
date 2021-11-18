require 'rails_helper'

RSpec.describe EntryGeocoder, type: :model do
  context 'with unequivocal location', :vcr do
    context 'when location name given' do
      let(:entry) { Entry.new(location: 'Dyszobaba', note: 'Some note') }
      let(:result) { EntryGeocoder.new(entry).call }
      it 'sets entry geographic coords to location coords' do
        expect(result.payload.latitude).to eq(52.9120427)
        expect(result.payload.longitude).to eq(21.398255)
      end
      it 'returns openstruct containing success boolean and entry' do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.successfull?).to be(true)
        expect(result.payload).to be_an_instance_of(Entry)
      end
    end
    context 'when location coordinates given' do
      let(:entry) { Entry.new(location: '52.9120427 21.398255', note: 'Some note') }
      let(:result) { EntryGeocoder.new(entry).call }
      it 'sets entry geographic coords to location coords' do
        expect(result.payload.latitude.round(2)).to eq(52.91)
        expect(result.payload.longitude.round(2)).to eq(21.4)
      end
      it 'sets location to location name' do
        expect(result.payload.location).to eq('Dyszobaba')
      end
      it 'returns openstruct containing success boolean and entry' do
        expect(result).to be_an_instance_of(OpenStruct)
        expect(result.successfull?).to be(true)
        expect(result.payload).to be_an_instance_of(Entry)
      end
    end
  end

  context 'with location that is not unequivocal', :vcr do
    let(:entry) { Entry.new(location: 'Borowa', note: 'Some note') }
    let(:result) { EntryGeocoder.new(entry).call }
    it 'adds errors containing multiple result message to entry' do
      expect(result.payload.errors.full_messages).not_to be_empty
      expect(result.payload.errors.full_messages).to include('Multiple locations found. First few:')
    end
    it 'returns openstruct containing failure boolean and entry' do
      expect(result).to be_an_instance_of(OpenStruct)
      expect(result.successfull?).to be(false)
      expect(result[:payload]).to be_an_instance_of(Entry)
    end
  end

  context 'with nonexistent location', :vcr do
    let(:entry) { Entry.new(location: 'ewathqegjhlj', note: 'Some note') }
    let(:result) { EntryGeocoder.new(entry).call }
    it 'adds errors containing invalid location message to entry' do
      expect(result.payload.errors.full_messages).not_to be_empty
      expect(result.payload.errors.full_messages).to include('Given location invalid')
    end
    it 'returns openstruct containing failure boolean and entry' do
      expect(result).to be_an_instance_of(OpenStruct)
      expect(result.successfull?).to be(false)
      expect(result[:payload]).to be_an_instance_of(Entry)
    end
  end
end