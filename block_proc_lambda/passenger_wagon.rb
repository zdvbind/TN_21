class PassengerWagon < Wagon
  def initialize(capacity)
    super(:passenger, capacity)
  end

  def description
    "Пассажирский вагон № #{@number}; свободных мест #{@capacity - @occupied}; занятых мест #{@occupied}"
  end
end
