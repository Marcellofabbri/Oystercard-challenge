class Oystercard
  attr_accessor :balance
  attr_reader :entry_station

  LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(balance: 0)
    @balance = balance
    @entry_station = nil
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    fail "Please top up" if balance < MINIMUM_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
  end

  private

  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end

end
