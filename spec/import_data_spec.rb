require 'rails_helper'

RSpec.describe ImportData, type: :service do
  describe "populate db" do
    data = JSON.parse(File.read('spec/data.json'), symbolize_names: true)

    ImportData.new('spec/data.json').exec

    cities = data.map{|el| [el[:to], el[:from]]}.flatten.uniq
    bus_services = data.map{|el| el[:bus][:services]}.flatten.uniq
    buses = data.map{|el| el[:bus][:number]}.flatten.uniq

    models = data.inject({}) do |acc,val|
      acc[val[:bus][:number]] = {
        model: val[:bus][:model],
        services: val[:bus][:services],
      }
      acc
    end

    it { expect(City.count).to eq(cities.size) }
    it { expect(Service.count).to eq bus_services.size }
    it { expect(Bus.count).to eq buses.size }
    it { expect(Trip.count).to eq data.size }

    Bus.find_each do |bus|
      it { expect(bus.model).to eq models[bus.number][:model] }
      it {
        expect(bus.services.map(&:name)).to eq models[bus.number][:services]
      }
    end
  end
end
