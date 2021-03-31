class Route
  attr_reader :station_list

  @@routes = {}

  def self.find_by_name(name)
    @@routes[name]
  end

  def initialize(name, first_station, end_station)
    @station_list = [first_station, end_station]
    @@routes[name] = self
  end

  def add_station(station)
    @station_list.insert(-2, station) unless @station_list.include?(station)
  end

  def del_station(station)
    return unless station != @station_list.first && station != @station_list.last && station_list.include?(station)

    @station_list.delete(station)
  end

  def show_stations
    @station_list.each { |station| puts station }
  end

  def first_station
    @station_list.first
  end

  def end_station
    @station_list.last
  end
end
