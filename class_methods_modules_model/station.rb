class Station
  include InstanceCounter
  attr_reader :trains, :title

  @@stations = {}

  def self.all
    @@stations
  end

  def self.find_by_name(name)
    @@stations[name]
  end

  def initialize(title)
    @title = title
    @trains = []
    @@stations[title] = self
    register_instance
  end

  def add_train(train)
    @trains << train unless @trains.include?(train)
  end

  def show_trains(type)
    @trains.select { |train| train.type == type }
  end

  def send_train(train)
    @trains.delete(train)
  end
end
