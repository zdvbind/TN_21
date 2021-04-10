# frozen_string_literal: true

class CargoWagon < Wagon
  validate :type, :permitted_value, WAGON_TYPES
  validate :capacity, :presence
  validate :capacity, :positive_value
  def initialize(capacity)
    super(:cargo, capacity)
  end

  def description
    "Cargo wagon № #{@number}; available plase #{@capacity - @occupied}; occupied place #{@occupied}"
  end
end
