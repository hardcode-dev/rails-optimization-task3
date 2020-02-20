class ImportService
  def self.call(*args)
    new(*args).call
  end

  def initialize(trip)
    @trip = trip
  end

  attr_reader :trip

  def call
  end
end
