require "rails_helper"
require "spec_helper"

describe "trips/index.html.erb" do
  let(:file_path) { Rails.root.join('fixtures', 'example.json') }
  let(:result_path) { Rails.root.join('fixtures', 'result_example.html') }

  before do
    TripsReloadService.new(file_path).run
  end

  it "displays all trips" do
    assign(:from, City.find_by_name('Самара'))
    assign(:to, City.find_by_name('Москва'))
    assign(:trips, Trip.where(from: City.find_by_name('Самара'), to: City.find_by_name('Москва')).order(:start_time))

    assign(:buses,
           Bus.includes(:services)
              .where(id: Trip.where(from: City.find_by_name('Самара'), to: City.find_by_name('Москва')).distinct.select(:bus_id))
              .index_by(&:id))

    render

    expect(rendered).to match_html(File.read(result_path))
  end
end
