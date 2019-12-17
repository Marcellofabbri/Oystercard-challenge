# frozen_string_literal: true

class Journey
  attr_reader :journey, :history
  PENALITY_FARE = 6

  def initialize
    @journey = {}
    @history = []
  end

  def create_entry(station)
    @journey[:entry] = station
  end

  def create_exit(station)
    @journey[:exit] = station
  end

  def add_journey
    @history << @journey
  end

  def in_journey?
    @journey.any?
  end

  def fare
    return PENALITY_FARE unless complete_journey?

    Oystercard::MINIMUM_CHARGE
  end

  def complete_journey?
    journey.key?(:entry) && journey.key?(:exit)
  end
end
