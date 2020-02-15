# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonLoadService do
  subject { JsonLoadService.call(file_name) }
  describe "small file parse" do
    let(:file_name) { "small.json" }
    it { expect { subject }.to perform_under(60).sec.warmup(2).times.sample(3).times }
  end

  describe "medium file parse" do
    let(:file_name) { "medium.json" }

    it {expect { subject }.to perform_under(60).sec.warmup(2).times.sample(2).times }
  end

  describe "large file parse" do
    let(:file_name) { "large.json" }

    it {expect { subject }.to perform_under(30).sec.warmup(2).times.sample(2).times }
  end

  describe "consistents" do
    let(:file_name) { "example.json" }

    context "Check structure" do
      it { expect { subject }.to change { City.all.size }.from(0).to(2)}
      it { expect { subject }.to change { Bus.all.size }.from(0).to(1) }
      it { expect { subject }.to change { Service.all.size }.from(0).to(2)}
      it { expect { subject }.to change { Trip.all.size }.from(0).to(10)}
    end
  end
end
