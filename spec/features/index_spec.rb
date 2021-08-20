require 'rails_helper'

feature 'Protect right rendering page' do
  let(:example_file) { Rails.root.join('spec', 'data', 'example.json') }
  let(:url) { URI.encode('/автобусы/Самара/Москва') }
  before { JsonReloader.new(example_file).call }

  context 'Index(Самара-Москва)' do
    before { visit url }

    it 'contain right information about route and right number of trips' do
      expect(page).to have_content 'Автобусы Самара – Москва'
      expect(page).to have_content 'В расписании 5 рейсов'
    end

    it 'contain information about buses' do
      Bus.all.each do |bus|
        expect(page).to have_content bus.model
        expect(page).to have_content bus.number
      end
    end

    it 'contain information about services' do
      Bus.all.each do |bus|
        bus.services { |s| expect(page).to have_content s.name } unless bus.services.nil?
      end
    end
  end
end
