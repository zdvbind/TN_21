class Wagon
  attr_reader :number, :type

  @@wagon_number = 1

  def initialize(type)
    @type = type
    @number = @@wagon_number.to_s
    @@wagon_number += 1
  end
end
