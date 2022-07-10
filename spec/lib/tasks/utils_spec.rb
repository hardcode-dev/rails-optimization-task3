require 'rails_helper'
require 'rake'
Rails.application.load_tasks

describe 'view schedule', type: :feature do
  subject do
    Rake::Task['reload_json'].reenable
    Rake::Task['reload_json'].invoke('fixtures/example.json')
  end

  it 'creates 10 trips' do
    expect { subject }.to change(Trip, :count).by(10)
  end

  it 'creates 2 cities' do
    expect { subject }.to change(City, :count).by(2)
  end

  it 'creates 2 services' do
    expect { subject }.to change(Service, :count).by(2)
  end

  it 'creates 2 buses' do
    expect { subject }.to change(Bus, :count).by(1)
  end
end
