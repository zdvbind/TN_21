class UserInterface
  def start
    loop do
      show_main_menu
      input = gets.chop.to_i
      case input
      when 1
        create_station
      when 2
        create_train
      when 3
        manage_route
      when 4
        add_route_to_train
      when 5
        add_wagon
      when 6
        remove_wagon
      when 7
        move_train
      when 8
        show_stations
      when 9
        show_trains
      when 10
        show_wagons
      when 11
        take_place
      when 0
        break
      else
        next
      end
    end
  end

  private

  def show_main_menu
    puts
    puts 'Нажмите соответствующую клавишу для перехода к нужному пункту меню'
    puts
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут или управлять им'
    puts '4. Назначить маршрут поезду'
    puts '5. Добавить вагон поезду'
    puts '6. Отцепить вагон от поезда'
    puts '7. Отправить поезд по маршруту вперед или назад'
    puts '8. Посмотреть список станций'
    puts '9. Посмотреть список поездов на стации'
    puts '10. Посмотреть список вагонов у поезда'
    puts '11. Занять место или объем в вагоне'
    puts '0. Выйти из программы'
    puts
  end

  def show_train_menu
    puts
    puts 'Нажмите соответствующую клавишу для перехода к нужному пункту меню'
    puts
    puts '1. Создать грузовой поезд'
    puts '2. Создать пассажирский поезд'
    puts
  end

  def show_route_menu
    puts
    puts 'Нажмите соответствующую клавишу для перехода к нужному пункту меню'
    puts
    puts '1. Добавить маршрут'
    puts '2. Добавить станцию к маршруту'
    puts '3. Удалить станцию из маршрута'
    puts
  end

  def show_move_train_menu
    puts
    puts 'Нажмите соответствующую клавишу для перехода к нужному пункту меню'
    puts
    puts '1. Переместить поезд по маршруту вперед'
    puts '2. Переместить поезд по маршруту назад'
    puts
  end

  def choose_train
    puts 'Введите номер поезда'
    title_train = gets.chomp.to_s
    if Train.find(title_train).nil?
      puts 'Поезда с таким номером не существует'
    else
      [Train.find(title_train), title_train]
    end
  end

  def choose_station
    puts 'Введите имя станции'
    title_station = gets.chomp.to_s
    if Station.find_by_name(title_station).nil?
      puts 'Такой станции не существует'
    else
      [Station.find_by_name(title_station), title_station]
    end
  end

  def choose_route
    puts 'Введите имя маршрута'
    title_route = gets.chomp.to_s
    if Route.find_by_name(title_route).nil?
      puts 'Такого маршрута не существует'
    else
      [Route.find_by_name(title_route), title_route]
    end
  end

  def choose_wagon
    puts 'Введите номер вагона'
    title_wagon = gets.chomp.to_s
    if Wagon.find(title_wagon).nil?
      puts 'Вагона с таким номером не существует'
    else
      [Wagon.find(title_wagon), title_wagon]
    end
  end

  def create_cargo_train
    puts 'Укажите номер поезда'
    title_tr = gets.chomp.to_s
    unless Train.find(title_tr).nil?
      puts 'Такой поезд уже существует'
      return
    end
    puts "Грузовой поезд #{title_tr} был создан" if CargoTrain.new(title_tr).valid?
  rescue ArgumentError => e
    puts "Грузовой поезд с номером #{title_tr} не создан , #{e.message}"
    retry
  end

  def create_passenger_train
    puts 'Укажите номер поезда'
    title_tr = gets.chomp.to_s
    unless Train.find(title_tr).nil?
      puts 'Такой поезд уже существует'
      return
    end
    puts "Пассажирский поезд #{title_tr} был создан" if PassengerTrain.new(title_tr).valid?
  rescue ArgumentError => e
    puts "Пассажирский поезд с номером #{title_tr} не создан , #{e.message}"
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
    puts 'Дайте имя станции'
    title_st = gets.chomp.to_s
    if Station.find_by_name(title_st).nil?
      Station.new(title_st)
    else
      puts 'Такая станция уже существует'
    end
  end

  def create_route
    puts 'Дайте имя маршруту'
    title_route = gets.chomp.to_s
    puts 'Введите имя первой станции'
    start_station = gets.chomp.to_s
    puts 'Введите имя последней станции'
    end_station = gets.chomp.to_s
    if Route.find_by_name(title_route).nil?
      Route.new(title_route, Station.find_by_name(start_station), Station.find_by_name(end_station))
    else
      puts 'Такой маршрут уже существует'
    end
  end

  def add_station_to_route
    station, station_name = choose_station
    route, route_name = choose_route
    return if station.nil? && route.nil?

    if route.add_station(station)
      puts "Станция #{station_name} добавлена в маршрут #{route_name}"
    else
      puts "Станция #{station_name} уже есть в маршруте #{route_name}"
    end
  end

  def remove_station_from_route
    station, station_name = choose_station
    route, route_name = choose_route
    return if station.nil? && route.nil?

    if route.del_station(station)
      puts "Станция #{station_name} удалена из маршрута #{route_name}"
    else
      puts "Станции #{station_name} нет в маршруте #{route_name} или она не является промежуточной"
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

  def add_route_to_train
    puts 'Введите номер поезда'
    title_train = gets.chomp.to_s
    puts 'Введите имя маршрута'
    title_route = gets.chomp.to_s
    if Train.find(title_train).nil?
      puts 'Такого поезда не существует'
    elsif Route.find_by_name(title_route).nil?
      puts 'Такого маршрута не существует'
    else
      Train.find(title_train).add_route(Route.find_by_name(title_route))
      puts "Маршрут #{title_route} добавлен поезду #{title_train}"
    end
  end

  def add_wagon
    train, train_name = choose_train
    train_type = train.type
    puts 'Введите вместимость вагона'
    capacity = gets.chomp.to_i
    if train_type == :cargo
      wagon = CargoWagon.new(capacity)
    else
      wagon = PassengerWagon.new(capacity)
    end
    train.add_wagon(wagon)
    puts "К поезду № #{train_name} добавили #{wagon.description}"
  end

  def remove_wagon
    train, train_name = choose_train
    train.del_wagon
    puts "От поезда № #{train_name} отцепили #{wagon.type} вагон №#{wagon.number}"
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
    puts "Поезд № #{train_name} прибыл на станцию #{train.current_station.title}"
  end

  def move_train_backward
    train, train_name = choose_train
    train.move_backward
    puts "Поезд № #{train_name} прибыл на станцию #{train.current_station.title}"
  end

  def show_stations
    Station.all.each_key { |name_s| puts name_s }
  end

  def show_trains
    station, station_name = choose_station
    puts "Список поездов на станции #{station_name}:"
    station.each_train { |train| puts train.notation_for_station }
  end

  def show_wagons
    train, = choose_train
    return unless train

    puts "Список вагонов у поезда #{train.notation_for_station}"
    train.each_wagon { |wagon| puts wagon.description }
  end

  def take_place
    wagon, = choose_wagon
    return unless wagon

    puts wagon.description
    if wagon.type == :cargo
      puts 'Какой объем занимаем ?'
      place = gets.chomp.to_i
      wagon.take_the_place(place)
    else
      wagon.take_the_place
    end
    puts 'Загрузка вагона прошла успешно'
    puts wagon.description
  end
end
