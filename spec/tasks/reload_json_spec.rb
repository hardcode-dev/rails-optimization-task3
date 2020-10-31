# frozen_string_literal: true

require 'rails_helper'

describe 'reload_json' do
  subject(:task) { ReimportDatabaseService.new(file_name: file).call }

  describe 'import result' do
    context 'with small file' do
      let(:file) { 'fixtures/small.json' }

      it 'reloads City data to database' do
        expect { task }.to change { City.count }.from(0).to(10)
                                                .and change { Bus.count }.from(0).to(613)
                                                                         .and change { Service.count }.from(0).to(10)
                                                                                                      .and change { Trip.count }.from(0).to(1000)
      end
    end
  end
end
