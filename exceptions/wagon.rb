class Wagon
  include Manufacturer
  include Validator
  attr_reader :number, :type

  WAGON_TYPES = [:cargo, :passenger].freeze

  @@wagon_number = 1

  def initialize(type)
    @type = type
    @number = @@wagon_number.to_s
    @@wagon_number += 1
    validate!
  end

  protected

  def validate!
    raise ArgumentError, 'Тип вагона может быть только :cargo или :passenger' unless WAGON_TYPES.include?(@type)
  end
end
