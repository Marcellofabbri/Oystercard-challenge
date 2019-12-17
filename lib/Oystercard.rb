class Oystercard
  attr_accessor :balance

  LIMIT = 90

  def initialize(balance: 0)
    @balance = balance
    @journey = false
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end

  def in_journey?
    @journey
  end

  def touch_in
    @journey = true
  end

  def touch_out
    @journey = false
  end

end
