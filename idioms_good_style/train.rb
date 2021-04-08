# frozen_string_literal: true

class Train
  include Manufacturer
  include InstanceCounter
  include Validator
  attr_reader :wagons, :type, :speed, :current_station, :number

  # rubocop:disable Style/ClassVars
  @@trains = {}
  # rubocop:enable Style/ClassVars
  NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze
  TRAIN_TYPES = %i[cargo passenger].freeze

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  class << self
    def find(name)
      @@trains[name]
    end

    def trains_list
      @@trains
    end
  end

  def add_speed
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if stopped? && !@wagons.include?(wagon)
  end

  def del_wagon
    @wagons.pop if stopped?
  end

  def quantity_wagons
    @wagons.size
  end

  def add_route(route)
    @route = route
    @current_station = @route.station_list[0]
    @current_station.add_train(self)
  end

  def next_station
    return unless @current_station != @route.end_station

    @route.station_list[@route.station_list.index(@current_station) + 1]
  end

  def previous_station
    return unless @current_station != @route.first_station

    @route.station_list[@route.station_list.index(@current_station) - 1]
  end

  def move_forward
    return unless next_station

    @current_station.send_train(self)
    next_station.add_train(self)
    @current_station = next_station
  end

  def move_backward
    return unless previous_station

    @current_station.send_train(self)
    previous_station.add_train(self)
    @current_station = previous_station
  end

  def each_wagon(&block)
    @wagons.each(&block)
  end

  def notation_for_station
    "Train №#{@number}, type #{@type}, number of wagons: #{quantity_wagons}"
  end

  protected

  ##
  # Moved to protected, since the method should be accessible for descendants, but not
  # from outside. This method is helper method - it is required for other methods of the class.
  def stopped?
    @speed.zero?
  end

  def validate!
    raise ArgumentError, 'The number does not have a valid format' unless @number =~ NUMBER
    raise ArgumentError, 'Type of train can be only :cargo or :passenger' unless TRAIN_TYPES.include?(@type)
  end
end
