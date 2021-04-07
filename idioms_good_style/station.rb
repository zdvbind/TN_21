class Station
  include InstanceCounter
  include Validator
  attr_reader :trains, :title

  # rubocop:disable Style/ClassVars
  @@stations = {}
  # rubocop:enable Style/ClassVars
  def self.all
    @@stations
  end

  def self.find(name)
    @@stations[name]
  end

  def initialize(title)
    @title = title
    @trains = []
    @@stations[title] = self
    register_instance
    validate!
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

  def each_train(&block)
    @trains.each(&block)
  end

  protected

  def validate!
    raise ArgumentError, 'Name of station can not be empty or nil' if @title.nil? || @title.empty?
  end
end
