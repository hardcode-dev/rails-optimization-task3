require "rails_helper"

RSpec.describe ImportData, type: :service do
  describe "populate db" do
    data = JSON.parse(File.read("spec/data.json"), symbolize_names: true)

    ImportData.new("spec/data.json").exec

    data.each do |trip|
      from = City.where(name: trip[:from])
      to = City.where(name: trip[:to])

      it { expect(from).to exist }
      it { expect(to).to exist }

      trip[:bus][:services].each do |service|
        it { expect(Service.where(name: service)).to exist }
      end

      buses = Bus.where(number: trip[:bus][:number])
      bus = buses.first

      it { expect(buses).to exist }
      it { expect(bus.try(:model)).to eq trip[:bus][:model] }

      it { expect(bus&.services.map(&:name)).to match_array trip[:bus][:services] }

      trips = Trip.where(
        from_id: from.first.id,
        to_id: to.first.id,
        bus_id: bus.id,
        start_time: trip[:start_time],
        duration_minutes: trip[:duration_minutes],
        price_cents: trip[:price_cents],
      )

      it { expect(trips).to exist }
    end
  end
end
