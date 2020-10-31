# frozen_string_literal: true

require "rails_helper"
Rails.application.load_tasks

describe "reload_json" do
  subject(:task) { Rake::Task["reload_json"].invoke(file) }

  describe "import result" do
    context "with small file" do
      let(:file) { "fixtures/small.json" }
      # let(:file) { 'fixtures/medium.json' }

      it "reloads City data to database" do
        expect { task }.to change { City.count }.from(0).to(10)
          .and change { Bus.count }.from(0).to(613)
          .and change { Service.count }.from(0).to(10)
          .and change { Trip.count }.from(0).to(1000)
      end
    end
  end
end
#   expect { task }.to change { City.count }.from(0).to(10)
#                                                .and change { Bus.count }.from(0).to(613)
#                                                .and change { Service.count }.from(0).to(10)
#                                                .and change { Trip.count }.from(0).to(1000)
#
#           expected `Bus.count` to have changed to 613, but is now 1000
#
#        ...and:
#
#           expected `Trip.count` to have changed to 1000, but is now 10000
