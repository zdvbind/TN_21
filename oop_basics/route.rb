class Route
  attr_reader :station_list

  def initialize(first_station, end_station)
    @station_list = [first_station, end_station]
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
      puts 'танция не является промежуточной, удалять нельзя'
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
