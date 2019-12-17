require 'journey'

describe Journey do
  let(:card) { double(:card, :touch_in => true) }
  let(:station_1) { double(:station_1) }
  let(:station_2) { double(:station_2) }

  it 'has a empy journey at creation' do
    expect(subject.journey).to be_empty
  end

  it "creates a complete journey" do
    subject.create_journey(station_1)
    subject.create_journey(station_2)
    expect(subject.journey).to include(:entry => station_1, :exit => station_2)
  end

  describe 'history' do
    it "is empty by default" do
      expect(subject.history).to be_empty
    end
  end


  describe 'in_journey?' do
    it "is false by default" do
      expect(subject).not_to be_in_journey
    end

    it "after touch in journey is true" do
      subject.create_journey(station_1)
      expect(subject).to be_in_journey
    end

    xit "after touch out journey is false" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end
  end

  describe '#fare' do
    it 'return the minimum fare' do
      subject.create_journey(station_1)
      subject.create_journey(station_2)
      expect(subject.fare).to eq Oystercard::MINIMUM_CHARGE
    end

    it 'return the penality if entry or exit are not recorded' do
      subject.create_journey(station_1)
      expect(subject.fare).to eq Journey::PENALITY_FARE
    end
  end
end

