# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'task', type: :task do
  Rails.application.load_tasks

  before do
    Rake::Task['reload_json'].reenable
  end

  let(:task) { Rake::Task['reload_json'] }

  it 'works creates Buses' do
    expect { task.invoke('fixtures/example.json') }.to change(Bus, :count).from(0).to(1)
  end

  it 'works creates Cities' do
    expect { task.invoke('fixtures/example.json') }.to change(City, :count).from(0).to(2)
  end

  it 'works creates Services' do
    expect { task.invoke('fixtures/example.json') }.to change(Service, :count).from(0).to(10)
  end
end
