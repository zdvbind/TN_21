# frozen_string_literal: true

class PassengerWagon < Wagon
  validate :type, :permitted_value, WAGON_TYPES
  validate :capacity, :presence
  validate :capacity, :positive_value
  def initialize(capacity)
    super(:passenger, capacity)
  end

  def description
    "Passenger wagon #{@number}; free seats #{@capacity - @occupied}; occupied seats #{@occupied}"
  end
end
