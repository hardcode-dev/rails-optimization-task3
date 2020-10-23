# frozen_string_literal: true

require 'rails_helper'
Rails.application.load_tasks

describe 'reload_json' do
  it 'it reloads data to database' do
    Rake::Task['reload_json'].invoke('fixtures/small.json')
    expect(Bus.count).to eq(613)
  end
end
