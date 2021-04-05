class CargoWagon < Wagon
  def initialize(capacity)
    super(:cargo, capacity)
  end

  def description
    "Грузовой вагон № #{@number}; свободный объем #{@capacity - @occupied}; занятый объем #{@occupied}"
  end
end
