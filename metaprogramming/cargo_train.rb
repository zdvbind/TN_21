# frozen_string_literal: true

class CargoTrain < Train
  validate :type, :permitted_value, TRAIN_TYPES
  validate :number, :format, NUMBER
  def initialize(number)
    super(number, :cargo)
  end
end
