class Station
  attr_reader :trains

  def initialize(title)
    @title = title
    @trains = []
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
