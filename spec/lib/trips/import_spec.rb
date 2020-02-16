require "rails_helper"

describe Trips::Import do
  include RSpec::Benchmark::Matchers

  let(:truncate_tables_command) { Utils::TruncateTables.new }
  let(:seed_services_command) { BusServices::Seed.new }
  let(:operation) { Trips::Import.new(truncate_tables_command, seed_services_command) }
  let(:connection) { ActiveRecord::Base.connection }

  describe "#call" do
    context "when example.json file" do
      let(:file_path) { File.join(Rails.root, "fixtures", "example.json") }

      it "should create valid data" do
        expect { operation.call(file_path: file_path) }
          .to change(Bus, :count).to(1)
          .and change(Service, :count).to(10)
          .and change(City, :count).to(2)
          .and change(Trip, :count).to(10)
          .and change { connection.execute("select count(*) from buses_services")[0]["count"] }.to(2)
      end
    end

    # Old import - ~25 sec
    # New import - ~0.7 sec
    context "when small.json file" do
      let(:file_path) { File.join(Rails.root, "fixtures", "small.json") }

      it "should work less then 1 second" do
        expect { operation.call(file_path: file_path) }.to perform_under(1).sec.warmup(2).times.sample(5).times
      end
    end
  end
end
