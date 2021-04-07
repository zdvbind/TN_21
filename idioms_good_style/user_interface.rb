class UserInterface
  include Menu

  USER_INPUT = {
    "1": :create_station,
    "2": :create_train,
    "3": :manage_route,
    "4": :add_route_to_train,
    "5": :add_wagon,
    "6": :remove_wagon,
    "7": :move_train,
    "8": :show_stations,
    "9": :show_trains,
    "10": :show_wagons,
    "11": :take_place
  }.freeze

  def start
    loop do
      show_main_menu
      input = gets.chomp.to_sym
      break if input == :"0"
      next unless USER_INPUT[input]

      send(USER_INPUT[input])
    end
  end

  private

  def choose_train
    puts 'Enter a train number'
    title_train = gets.chomp.to_s
    if Train.find(title_train).nil?
      puts 'This train already exists'
    else
      [Train.find(title_train), title_train]
    end
  end

  def choose_station
    puts 'Enter a name of station'
    title_station = gets.chomp.to_s
    if Station.find(title_station).nil?
      puts 'This station does not exist'
    else
      [Station.find(title_station), title_station]
    end
  end

  def choose_route
    puts 'Enter the title of route'
    title_route = gets.chomp.to_s
    if Route.find(title_route).nil?
      puts 'This route does not exist'
    else
      [Route.find(title_route), title_route]
    end
  end

  def choose_wagon
    puts 'Enter a wagon number'
    title_wagon = gets.chomp.to_s
    if Wagon.find(title_wagon).nil?
      puts 'The wagon with this number does not exist'
    else
      [Wagon.find(title_wagon), title_wagon]
    end
  end

  def create_cargo_train
    puts 'Enter a train number'
    title_tr = gets.chomp.to_s
    unless Train.find(title_tr).nil?
      puts 'This train already exists'
      return
    end
    puts "Cargo train #{title_tr} has been created" if CargoTrain.new(title_tr).valid?
  rescue ArgumentError => e
    puts "Cargo train with number #{title_tr} was not created , #{e.message}"
    retry
  end

  def create_passenger_train
    puts 'Enter a train number'
    title_tr = gets.chomp.to_s
    unless Train.find(title_tr).nil?
      puts 'This train already exists'
      return
    end
    puts "Passenger train #{title_tr} has been created" if PassengerTrain.new(title_tr).valid?
  rescue ArgumentError => e
    puts "Passenger train with number #{title_tr} was not created , #{e.message}"
    retry
  end

  def create_train
    show_train_menu
    input = gets.chomp.to_i
    case input
    when 1
      create_cargo_train
    when 2
      create_passenger_train
    end
  end

  def create_station
    puts 'Enter a name of station'
    title_st = gets.chomp.to_s
    if Station.find(title_st).nil?
      Station.new(title_st)
    else
      puts 'This station already exists'
    end
  end

  def create_route_data
    puts 'Enter the name of the route'
    title_route = gets.chomp.to_s
    puts 'Enter the name of the first station'
    start_station = gets.chomp.to_s
    puts 'Enter the name of the last station'
    end_station = gets.chomp.to_s
    [title_route, start_station, end_station]
  end

  def create_route
    title, start, finish = create_route_data
    if Route.find(title).nil?
      Route.new(title, Station.find(start), Station.find(finish))
    else
      puts 'This route already exists'
    end
  end

  def add_station_to_route
    station, station_name = choose_station
    route, route_name = choose_route
    return if station.nil? && route.nil?

    if route.add_station(station)
      puts "Station #{station_name} was added to route #{route_name}"
    else
      puts "Station #{station_name} already exists in the route #{route_name}"
    end
  end

  def remove_station_from_route
    station, station_name = choose_station
    route, route_name = choose_route
    return if station.nil? && route.nil?

    if route.del_station(station)
      puts "Station #{station_name} was deleted from route #{route_name}"
    else
      puts "Station #{station_name} does not exists in the route #{route_name} or it is first or last station"
    end
  end

  def manage_route
    show_route_menu
    input = gets.chomp.to_i
    case input
    when 1
      create_route
    when 2
      add_station_to_route
    when 3
      remove_station_from_route
    end
  end

  def add_route_to_train_data
    puts 'Enter a train number'
    title_train = gets.chomp.to_s
    puts 'Enter the name of the route'
    title_route = gets.chomp.to_s
    [title_train, title_route]
  end

  def add_route_to_train
    train, route = add_route_to_train_data
    if Train.find(train).nil?
      puts 'This train does not exist'
    elsif Route.find(route).nil?
      puts 'This route does not exist'
    else
      Train.find(train).add_route(Route.find(route))
      puts "The route #{route} was added to #{train}"
    end
  end

  def add_wagon
    train, train_name = choose_train
    puts 'Enter the capacity of wagon'
    capacity = gets.chomp.to_i
    wagon = if train.type == :cargo
              CargoWagon.new(capacity)
            else
              PassengerWagon.new(capacity)
            end
    train.add_wagon(wagon)
    puts "#{wagon.description} was added to train № #{train_name}"
  end

  def remove_wagon
    train, train_name = choose_train
    train.del_wagon
    puts "Last wagon was removed from train № #{train_name}"
  end

  def move_train
    show_move_train_menu
    input = gets.chomp.to_i
    case input
    when 1
      move_train_forward
    when 2
      move_train_backward
    end
  end

  def move_train_forward
    train, train_name = choose_train
    train.move_forward
    puts "train № #{train_name} arrived to the station #{train.current_station.title}"
  end

  def move_train_backward
    train, train_name = choose_train
    train.move_backward
    puts "train № #{train_name} arrived to the station #{train.current_station.title}"
  end

  def show_stations
    Station.all.each_key { |name_s| puts name_s }
  end

  def show_trains
    station, station_name = choose_station
    puts "Train list by the station #{station_name}:"
    station.each_train { |train| puts train.notation_for_station }
  end

  def show_wagons
    train, = choose_train
    return unless train

    puts "Wagon list by the train #{train.notation_for_station}"
    train.each_wagon { |wagon| puts wagon.description }
  end

  def take_place
    wagon, = choose_wagon
    return unless wagon

    puts wagon.description
    if wagon.type == :cargo
      wagon.take_the_place(input_place)
    else
      wagon.take_the_place
    end
    puts "The wagon was succesfully loaded.\n#{wagon.description}"
  end

  def input_place
    puts 'What value to take?'
    gets.chomp.to_i
  end
end
