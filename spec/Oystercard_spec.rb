require 'Oystercard'

describe Oystercard do

  let(:station) { double(:station) }
  let(:station2) { double(:station2) }

  describe '#balance' do
    it "has a default balance of zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it "raises an error when trying to exceed limit of 90" do
      cap = Oystercard::LIMIT
      subject.top_up(cap)
      expect{ subject.top_up 1 }.to raise_error "Cannot exceed 90"
    end
  end

  describe '#deduct' do

    it "raises an error when trying to deduct more than the balance" do
      expect{ subject.touch_out(station) }.to raise_error "Insufficient funds"
    end
  end

  describe 'in_journey?' do
    it "is false by default" do
      expect(subject).not_to be_in_journey
    end
  end

  describe 'touch_in' do
    it "after touch in journey is true" do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end
    it "raises error when balance is less than minimum charge" do
      expect{ subject.touch_in(station) }.to raise_error "Please top up"
    end
    it "saved entry_station" do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe 'touch_out' do
    it "after touch out journey is false" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end
    it "forgets entry_station" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end
    # it "saves exit_station" do
    #   subject.top_up(1)
    #   subject.touch_out(station2)
    #   expect(subject.exit_station).to eq station2
    # end
    it "deducts the fare for the journey" do
      subject.top_up(1)
      expect { subject.touch_out(station) }.to change{subject.balance}.by(-1)
    end
  end

  describe 'journey' do
    it "creates a journey" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station2)
      expect(subject.journey).to include(:entry => station, :exit => station2)
    end
  end

  describe 'history' do
    it "is empty by default" do
      expect(subject.history).to be_empty
    end
  end
end