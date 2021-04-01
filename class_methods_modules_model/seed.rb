eburg = Station.new('eburg')
orenburg = Station.new('orenburg')
chelabinsk = Station.new('chelabinsk')
orsk = Station.new('orsk')
mednogorsk = Station.new('mednogorsk')
kuvandik = Station.new('kuvandik')
route1 = Route.new(eburg, orenburg)
route1.add_station(chelabinsk)
route1.station_list
route1.show_stations
route1.add_station(orsk)
route1.del_station(orsk)
route1.show_stations
route1.add_station(orsk)
route1.add_station(mednogorsk)
route1.add_station(kuvandik)
pt200 = PassengerTrain.new(200)
pw1 = PassengerWagon.new
pw2 = PassengerWagon.new
pt200.add_wagon(pw1)
pt200.add_wagon(pw2)
pt200.add_wagon(pw1)
pt200.wagons
pt200.add_route(route1)
pt200.move_forward
pt200.move_forward
pt200.move_forward
pt200.move_backward
puts pt200.wagons
puts pt200.quantity_wagons

# train200.add_route(route1)
# train200.move_forward
