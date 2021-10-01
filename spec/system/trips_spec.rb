# frozen_string_literal: true

require 'rails_helper'

describe 'Schedule', type: :feature do
  before do
    DataImporter.call('fixtures/example.json')
  end

  it 'visit trips page' do
    visit '/%D0%B0%D0%B2%D1%82%D0%BE%D0%B1%D1%83%D1%81%D1%8B/%D0%A1%D0%B0%D0%BC%D0%B0%D1%80%D0%B0/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0'
    expect(page.find('body').base.native.to_s).to eq(file_fixture('trips.html').read)
  end
end