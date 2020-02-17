class ImportService
  def initialize(trip)
    @trip = trip
  end

  attr_reader :trip

  def perform
    print "#{trip}\n\n"
  end
end
