require 'rails_helper'
require 'rake'
Rails.application.load_tasks

describe 'reload_json' do
  subject { invoke }

  let(:file) { 'fixtures/example.json' }

  def invoke
    Rake::Task['reload_json'].reenable
    Rake::Task['reload_json'].invoke(file)
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

  describe 'performance' do
    let(:file) { 'fixtures/small.json' }

    it 'executes less than 1 sec' do
      expect { invoke }.to perform_under(0.4).sec
    end
  end
end
