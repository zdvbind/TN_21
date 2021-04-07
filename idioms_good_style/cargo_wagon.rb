class CargoWagon < Wagon
  def initialize(capacity)
    super(:cargo, capacity)
  end

  def description
    "Cargo wagon № #{@number}; available plase #{@capacity - @occupied}; occupied place #{@occupied}"
  end
end
