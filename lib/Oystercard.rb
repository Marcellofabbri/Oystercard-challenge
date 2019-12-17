class Oystercard
  attr_accessor :balance

  LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(balance: 0)
    @balance = balance
    @journey = false
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def in_journey?
    @journey
  end

  def touch_in
    fail "Please top up" if balance < MINIMUM_CHARGE
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_CHARGE)
    @journey = false
  end

  private
  
  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end

end
