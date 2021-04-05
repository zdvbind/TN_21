class Wagon
  include Manufacturer
  include Validator
  attr_reader :number, :type, :occupied

  WAGON_TYPES = [:cargo, :passenger].freeze

  @@wagon_number = 1
  @@wagons = {}

  def initialize(type, capacity)
    @type = type
    @number = @@wagon_number.to_s
    @@wagon_number += 1
    @capacity = capacity
    @occupied = 0
    validate!
    @@wagons[@number] = self
  end

  def self.find(number)
    @@wagons[number]
  end

  def take_the_place(place = 1)
    raise 'Wagon is full' if (@occupied + place) > @capacity

    @occupied += place
  end

  def available
    @capacity - @occupied
  end

  protected

  def validate!
    raise ArgumentError, 'Тип вагона может быть только :cargo или :passenger' unless WAGON_TYPES.include?(@type)
    raise ArgumentError, 'Вместимость вагона может быть только положительной' unless @capacity > 0
  end
end
