require "rails_helper"

RSpec.describe TripsImporter, type: :service do
  it "imports cities and trips" do
    expect do
      described_class.call(Rails.root.join("fixtures/example.json"))
    end.to change(City, :count).by(2).and change(Service, :count).by(2).and change(Bus, :count).by(1).and change(Trip, :count).by(10)

    expect(Bus.last.services.count).to eq(2)
  end
end
