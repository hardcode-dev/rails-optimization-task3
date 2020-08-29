require "rails_helper"

feature "User visits trips index page" do
  let(:file_path) { File.join(Rails.root, "fixtures", "example.json") }

  context "when from city Самара, to city Москва" do
    before do
      TripsContainer["import"].call(file_path: file_path)
    end

    it "should contain valid blocks count" do
      visit trips_index_path(from: "Самара", to: "Москва")

      trips = page.all(:css, ".trip").count

      expect(trips).to eq(5)
    end
  end
end
