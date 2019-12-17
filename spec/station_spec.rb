require 'station'

describe Station do
  describe '#initialize' do
    subject { Station.new("Oxford", 1) }

    it 'has a name' do
      expect(subject.name).to eq "Oxford"
    end

    it 'has a zone' do
      expect(subject.zone).to eq 1
    end
  end
end