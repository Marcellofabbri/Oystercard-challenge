class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey, :history

  LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(balance: 0)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @journey = nil
    @history = []
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

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @exit_station = station
    add_journey
    @entry_station = nil
    @exit_station = nil
  end

  private

  def add_journey
    history << create_journey
  end

  def create_journey
    @journey = { :entry => entry_station, :exit => exit_station }
  end

  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end

end
