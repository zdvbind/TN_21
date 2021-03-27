class Train
  attr_reader :quantity_wagons, :type, :speed, :current_station

  def initialize(number, type, quantity_wagons)
    @number = number
    @type = type
    @quantity_wagons = quantity_wagons
    @speed = 0
  end

  def add_speed
    @speed += 1
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @quantity_wagons += 1 if @speed.zero?
  end

  def del_wagons
    @quantity_wagons -= 1 if @quantity_wagons.positive? && @speed.zero?
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
end
