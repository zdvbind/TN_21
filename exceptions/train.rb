class Train
  include Manufacturer
  include InstanceCounter
  include Validator
  attr_reader :wagons, :type, :speed, :current_station, :number

  @@trains = {}

  NUMBER = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze
  TRAIN_TYPES = [:cargo, :passenger].freeze

  def initialize(number, type)
    @number = number
    @type = type
    @wagons = []
    @speed = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  def self.find(name)
    @@trains[name]
  end

  def self.trains_list
    @@trains
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

  protected

  ##
  # Вынесли в protected, так как метод должен быть доступен для потомков, но не доступен
  # извне. Метод вспомогательный, необходим для других методов класса.

  def stopped?
    @speed.zero?
  end

  def validate!
    raise ArgumentError, 'У номера невалидный формат' unless @number =~ NUMBER
    raise ArgumentError, 'Тип поезда может быть только :cargo или :passenger' unless TRAIN_TYPES.include?(@type)
  end
end
