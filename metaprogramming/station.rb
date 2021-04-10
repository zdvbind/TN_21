# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation
  attr_reader :trains, :title

  validate :title, :presence

  # rubocop:disable Style/ClassVars
  @@stations = {}
  # rubocop:enable Style/ClassVars
  class << self
    def all
      @@stations
    end

    def find(name)
      @@stations[name]
    end
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
end
