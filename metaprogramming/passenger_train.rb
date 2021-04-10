# frozen_string_literal: true

class PassengerTrain < Train
  validate :type, :permitted_value, TRAIN_TYPES
  validate :number, :format, NUMBER
  def initialize(number)
    super(number, :passenger)
  end
end
