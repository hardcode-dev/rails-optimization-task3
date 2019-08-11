require 'spec_helper'

describe 'reload_json', :rake do
  subject { Rake.application.invoke_task 'reload_json[fixtures/large.json]' }

  it 'should perform under 30 s' do
    expect{ subject }.to perform_under(60).sec
  end
end
