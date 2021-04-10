# frozen_string_literal: true

require_relative 'accessors'
require_relative 'validation'
require_relative 'instance_counter'
require_relative 'station'
require_relative 'route'
require_relative 'manufacturer'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'

def test
  puts '--------------------'
  yield
  puts 'Validate succesful'
rescue ArgumentError => e
  puts e.message
end

test do
  puts 'CargoTrain.new(12)'
  CargoTrain.new(12)
end
test do
  puts "CargoTrain.new('12122')"
  CargoTrain.new('12122')
end
test do
  puts "Train.new('AS122')"
  Train.new('AS122')
end
test do
  puts "Train.new('AS122', :cargo)"
  Train.new('AS122', :cargo)
end
test do
  puts "Train.new('AS122', :bla)"
  Train.new('AS122', :bla)
end
test do
  puts "Train.new('AS1223232', :cargo)"
  Train.new('AS1223232', :cargo)
end
test do
  puts 'PassengerTrain.new(12)'
  PassengerTrain.new(12)
end
test do
  puts "PassengerTrain.new('12122')"
  PassengerTrain.new('12122')
end
test do
  puts "Station.new('Moscow')"
  Station.new('Moscow')
end
test do
  puts "Station.new('nil')"
  Station.new(nil)
end
test do
  puts "Route.new(nil, Station.new('Moscow'), nil)"
  Route.new(nil, Station.new('Moscow'), nil)
end
test do
  puts "Route.new('r1', Station.new('Moscow'), Station.new('Kursk'))"
  Route.new('r1', Station.new('Moscow'), Station.new('Kursk'))
end
test do
  puts "Route.new('r1', Station.new('Moscow'), Station.new(nil))"
  Route.new('r1', Station.new('Moscow'), Station.new(nil))
end
test do
  puts 'Wagon.new(:cargo, 45)'
  Wagon.new(:cargo, 45)
end
test do
  puts 'Wagon.new(:cargo, -10)'
  Wagon.new(:cargo, -10)
end
test do
  puts 'Wagon.new(:ref, 45)'
  Wagon.new(:ref, 45)
end
test do
  puts 'Wagon.new(:passenger, nil )'
  Wagon.new(:passenger, nil)
end
test do
  puts 'Wagon.new(nil, nil )'
  Wagon.new(nil, nil)
end
test do
  puts 'CargoWagon.new(-25)'
  CargoWagon.new(-25)
end

puts "\n\n-----------------------------------"
puts 'attr_accessor_with_history'
puts '-----------------------------------'

wc200 = Wagon.new(:cargo, 100)
puts wc200.inspect
wc200.color = 'red'
wc200.color = 'white'
wc200.color = 'blue'
puts wc200.color
puts wc200.color_history.to_s

puts "\n\n-----------------------------------"
puts 'strong_attr_accessor'
puts '-----------------------------------'

class Table
  include Accessors
  strong_attr_accessor :autor, String
end

t = Table.new
begin
  t.autor = 'PapaCarlo'
  puts t.autor
  t.autor = 22
rescue ArgumentError => e
  puts e.message
end
