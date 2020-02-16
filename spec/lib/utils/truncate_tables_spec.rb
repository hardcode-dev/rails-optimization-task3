require "rails_helper"

describe Utils::TruncateTables do
  let(:operation) { described_class.new }

  describe "#call" do
    it "should remove all table rows" do
      FactoryBot.create(:bus)

      expect(Bus.count).to eq(1)

      operation.call(tables: ["buses"])

      expect(Bus.count).to eq(0)
    end
  end
end
