# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe '#utils' do
  subject { Rake::Task['reload_json'].invoke(file_name) }

  let(:file_name) { 'fixtures/example.json' }

  context 'when work correctly' do
    specify do
      subject

      expect(Bus.count).to eq(1)
      expect(City.count).to eq(2)
      expect(Service.count).to eq(2)
      expect(Trip.count).to eq(10)
    end

    context 'and good perfomance' do
      let(:budget) { 1 }

      specify do
        expect { subject }.to perform_under(budget).sec.warmup(1).times.sample(10).times
      end
    end
  end
end
