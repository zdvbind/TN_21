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
    if @station_list.include?(station)
      puts 'This station already exists in route'
    else
      @station_list.insert(-2, station)
    end
  end

  def del_station(station)
    if station == @station_list[0] || station == @station_list[-1]
      puts 'Cтанция не является промежуточной, удалять нельзя'
    elsif station_list.include?(station)
      @station_list.delete(station)
    else
      puts 'Такой станции нет в маршруте'
    end
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
