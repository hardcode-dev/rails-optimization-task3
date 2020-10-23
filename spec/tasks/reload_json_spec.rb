# frozen_string_literal: true

require 'rails_helper'
Rails.application.load_tasks

describe 'reload_json' do
  subject(:task) { Rake::Task['reload_json'].invoke(file) }

  describe 'import result' do
    context 'with small file' do
      let(:file) { 'fixtures/small.json' }
      let(:clear_database) do
        City.delete_all
        Bus.delete_all
        Service.delete_all
        Trip.delete_all
      end

      before { clear_database }

      # it 'reloads City data to database' do
      #   expect { task }.to change { City.count }.from(0).to(10)
      # end

      it 'reloads Bus data to database' do
        expect { task }.to change { Bus.count }.from(0).to(613)
      end

      # it 'reloads Service data to database' do
      #   expect { task }.to change { Service.count }.from(0).to(10)
      # end
      #
      # it 'reloads Trip data to database' do
      #   expect { task }.to change { Trip.count }.from(0).to(1000)
      # end
    end
  end
end
