require "rails_helper"

describe BusServices::Seed do
  let(:operation) { described_class.new }

  describe "#call" do
    it "should create all services" do
      expect { operation.call }.to change(Service, :count).to(Service::SERVICES.count)
    end
  end
end
