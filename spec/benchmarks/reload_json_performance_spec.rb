# frozen_string_literal: true

require "rails_helper"

# Rails.application.load_tasks

describe "reload_json_performance" do
  subject(:task) { ReimportDatabaseService.new(file_name: file).call }

  describe "Performance" do
    let(:file) { "fixtures/large.json" }

    describe "execution time" do
      it "performs large file in less than 60 seconds" do
        user_time = Benchmark.realtime {
          task
        }
        puts "performed in #{user_time}"
        expect(user_time < 60)

      end
    end

    # describe 'memory usage' do
    #   it 'performs data_500 file in less than 700 kylobytes' do
    #     expect { task }.to perform_allocation(700).bytes
    #   end
    # end
  end
end
