require 'rails_helper'

describe 'rake reload_json', :rake do
  subject { Rake.application.invoke_task 'reload_json[fixtures/large.json]' }

  it 'should perform under 60 s' do
    expect{ subject }.to perform_under(60).sec
  end
end
