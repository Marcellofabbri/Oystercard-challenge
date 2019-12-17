require 'Oystercard'

describe Oystercard do

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
    it "deducts the fare from the balance" do
      subject.top_up(1)
      expect{ subject.deduct 1 }.to change{ subject.balance }.by -1
    end

    it "raises an error when trying to deduct more than the balance" do
      expect{ subject.deduct 1 }.to raise_error "Insufficient funds"
    end
  end

  describe 'in_journey?' do
    it "is false by default" do
      expect(subject).not_to be_in_journey
    end
  end

  describe 'touch_in' do
    it "after touch in journey is true" do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe 'touch_out' do
    it "after touch out journey is false" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end
end