class Wagon
  include Manufacturer
  include Validator
  attr_reader :number, :type, :occupied

  WAGON_TYPES = %i[cargo passenger].freeze
  # rubocop:disable Style/ClassVars
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
  # rubocop:enable Style/ClassVars

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
    raise ArgumentError, 'Type of wagon can be  only :cargo or :passenger' unless WAGON_TYPES.include?(@type)
    raise ArgumentError, 'Wagon capacity can be only positive' unless @capacity.positive?
  end
end
