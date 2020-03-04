# frozen_string_literal: true

require "rails_helper"

RSpec.describe ScheduleLoader do
  describe "loading small file" do
    it { expect { ScheduleLoader.call("fixtures/small.json") }.to perform_under(0.005).sec }
  end

  # describe "loading medium file" do
  #   it {expect { ScheduleLoader.call('fixtures/medium.json') }.to perform_under(60).sec }
  # end

  # describe "loading large file" do
  #   let(:file_name) { "fixtures/large.json" }
  #
  #   it {expect { ScheduleLoader.call('fixtures/large.json') }.to perform_under(60).sec }
  # end
end
