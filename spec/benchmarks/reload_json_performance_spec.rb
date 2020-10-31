# frozen_string_literal: true

require "rails_helper"

describe "reload_json_performance" do
  subject(:task) { ReimportDatabaseService.new(file_name: file).call }

  describe "Performance" do
    let(:file) { "fixtures/large.json" }

    describe "execution time" do
      it "performs large file in less than 60 seconds" do
        expect { task }.to perform_under(30).sec
      end
    end
  end
end
