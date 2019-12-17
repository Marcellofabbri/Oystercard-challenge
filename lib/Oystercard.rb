require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey, :history

  LIMIT = 90
  MINIMUM_CHARGE = 1

  def initialize(balance: 0)
    @balance = balance
    @journey = Journey.new
  end

  def top_up(amount)
    fail "Cannot exceed 90" if (amount + balance) > LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail "Please top up" if balance < MINIMUM_CHARGE
    journey.create_journey(station)
  end

  def touch_out(station)
    deduct
    journey.create_journey(station)
    journey.add_journey
  end

  private

  def deduct
    fail "Insufficient funds" if (balance - journey.fare) < 0
    @balance -= journey.fare
  end
end
