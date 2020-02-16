require "rails_helper"

RSpec.describe "Check buses", :type => :request do

  it "shows direction moscow-samara" do

    Importer.new.import('fixtures/example.json')

    get URI.escape("/автобусы/Самара/Москва")


    #File.write('x1', response.body)

    expect(response.body).to eq(File.read(Rails.root.join('spec/requests/example_json_response.html')))
  end

end