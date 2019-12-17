require_relative 'station'

class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey, :history

  LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(balance: 0)
    @balance = balance
    @journey = {}
    @history = []
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def in_journey?
    @journey.any?
  end

  def touch_in(station)
    fail "Please top up" if balance < MINIMUM_CHARGE
    create_entry(station)
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    create_exit(station)
    add_journey
  end

  private

  def add_journey
    history << @journey
  end

  def create_entry(station)
    @journey[:entry] = station
  end

  def create_exit(station)
    @journey[:exit] = station
  end

  def deduct(fare)
    fail "Insufficient funds" if (balance - fare) < 0
    @balance -= fare
  end
end
