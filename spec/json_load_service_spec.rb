# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonLoadService do
  describe "small file parse" do
    let(:file_name) { "small.json" }
    it { expect { JsonLoadService.call(file_name) }.to perform_under(60).sec.warmup(2).times.sample(3).times }
  end

  # describe "medium file parse" do
  #   let(:file_name) { "medium.json" }
  #   DatabaseCleaner.cleaning do
  #     it {expect { JsonLoadService.call(file_name) }.to perform_under(60).sec.warmup(1).times.sample(1).times }
  #   end
  # end
end
