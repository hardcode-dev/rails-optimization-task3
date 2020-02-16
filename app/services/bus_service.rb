class BusService
  attr_reader :bus, :services

  def initialize(services)
    @bus = {}
    @services = services
  end

  def check_bus(number, model: nil, service: nil)
    return bus[number] if bus[number].present?

    @bus[number] = Bus.new(number: number,
                         model: model,
                         services: service.inject([]) { |arr, el| arr << services[el]; arr; })
  end

  def get_array
    bus.map { |_k, v| v }
  end
end
