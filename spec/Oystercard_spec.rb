require 'Oystercard'

describe Oystercard do

  describe '#balance' do
    it "has a default balance of zero" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it "lets users change the balance" do
      expect{ subject.top_up(6)}.to change{ subject.balance }.by 6
    end
    it "does not let users top up to more than 90" do
      expect{ subject.top_up(91)}.to change{ subject.balance }.by 0
    end
    it "raises an error when trying to change balance to an amount over 90" do
      expect{ subject.top_up(1) }.to raise_error "Balance can't be over 90" if subject.balance > subject.limit
    end
  end

end