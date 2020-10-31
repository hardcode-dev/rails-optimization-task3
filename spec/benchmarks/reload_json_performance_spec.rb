# frozen_string_literal: true

require "rails_helper"

# Rails.application.load_tasks

describe "reload_json_performance" do
  subject(:task) { Rake::Task["reload_json"].invoke(file) }

  describe "Performance" do
    let(:file) { "fixtures/large.json" }

    describe "execution time" do
      it "performs large file in less than 30 seconds" do
        user_time = Benchmark.realtime {
          task
        }
        expect(user_time < 30)
      end
    end

    # describe 'memory usage' do
    #   it 'performs data_500 file in less than 700 kylobytes' do
    #     expect { task }.to perform_allocation(700).bytes
    #   end
    # end
  end
end
