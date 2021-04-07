class PassengerWagon < Wagon
  def initialize(capacity)
    super(:passenger, capacity)
  end

  def description
    "Passenger wagon #{@number}; free seats #{@capacity - @occupied}; occupied seats #{@occupied}"
  end
end
