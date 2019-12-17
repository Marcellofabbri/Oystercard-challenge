class Oystercard
  attr_accessor :balance

  LIMIT = 90

  def initialize(balance: 0)
    @balance = balance
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end
end
