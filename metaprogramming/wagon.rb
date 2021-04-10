# frozen_string_literal: true

class Wagon
  include Manufacturer
  include Validation
  include Accessors
  attr_reader :number, :type, :occupied, :capacity

  attr_accessor_with_history :color
  WAGON_TYPES = %i[cargo passenger].freeze
  validate :type, :permitted_value, WAGON_TYPES
  validate :capacity, :presence
  validate :capacity, :positive_value
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
end
