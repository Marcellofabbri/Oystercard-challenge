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

  describe 'touch_in' do
    it "raises error when balance is less than minimum charge" do
      expect{ subject.touch_in(station) }.to raise_error "Please top up"
    end
  end

  describe 'touch_out' do
    it "deducts the fare for the journey" do
      subject.top_up(10)
      expect { subject.touch_out(station) }.to change{subject.balance}.by(-Journey::PENALITY_FARE)
    end
  end
end
