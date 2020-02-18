require "rails_helper"

RSpec.describe "Check buses", :type => :request do

  it "shows direction moscow-samara" do

    Importer.new.import('fixtures/example.json')

    get URI.escape("/автобусы/Самара/Москва")


    #File.write('x1', response.body)


    expect(response.body.delete(" \r\t\n")).to eq(File.read(Rails.root.join('spec/requests/example_json_response.html')).delete(" \r\t\n"))
  end


  it "query limit" do

    Importer.new.import('fixtures/example.json')
    
    expect { get URI.escape("/автобусы/Самара/Москва") }.not_to exceed_query_limit(3)

  end

end