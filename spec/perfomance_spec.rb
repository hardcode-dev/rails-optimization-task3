require 'spec_helper.rb'

RSpec.describe "Performance testing" do
  it{ expect { system 'rake reload_json[fixtures/example.json]' }.to perform_under(1.2).sec }
  # it{ expect { system 'rake reload_json[fixtures/medium.json]' }.to perform_under(24).sec }
  # it{ expect { system 'rake reload_json[fixtures/large.json]' }.to perform_under(210).sec }
end
