# frozen_string_literal: true

require "rails_helper"

RSpec.describe JsonLoadService do
  subject { JsonLoadService.call(file_name) }

  describe "consistents" do
    let(:file_name) { "example.json" }

    context "Check structure" do
      it { expect { subject }.to change { City.all.size }.from(0).to(2)}
      it { expect { subject }.to change { Bus.all.size }.from(0).to(1) }
      it { expect { subject }.to change { Trip.all.size }.from(0).to(10)}
      it "check enum bus" do
        subject
        result = Bus.last.take_services
        expect(result).to eq ["WiFi", "Туалет"]
      end
    end
  end

  describe "small file parse" do
    let(:file_name) { "small.json" }
    it { expect { subject }.to perform_under(60).sec }
  end

  describe "medium file parse" do
    let(:file_name) { "medium.json" }

    it {expect { subject }.to perform_under(60).sec }

  end

  describe "large file parse" do
    let(:file_name) { "large.json" }

    it {expect { subject }.to perform_under(60).sec }
  end
end
