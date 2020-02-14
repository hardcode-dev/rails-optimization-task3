class CiteService
  attr_reader :city

  def initialize
    @city = {}
  end

  def check_city(name)
    return city[name] if city[name].present?

    @city[name] = City.new(name: name)
  end

  def get_array
    city.map { |_k, v| v }
  end
end
