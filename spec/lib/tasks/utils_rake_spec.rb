# frozen_string_literal: true

require 'rails_helper'
require 'rake'

describe 'rake reload_json' do
  before do
    Rails.application.load_tasks
  end

  after { task.reenable }

  let(:task) { Rake::Task['utils:reload_json'] }
  let(:path) { 'spec/fixtures/data.json' }
  let(:expected_result) do
    {
      from: 'Сочи',
      to: 'Тула',
      start_time:'16:11',
      duration_minutes:83,
      price_cents:23354,
      bus:{
        number:'229',
        model:'Икарус',
        services:[
          'Ремни безопасности',
          'Кондиционер общий',
          'Кондиционер Индивидуальный',
          'Телевизор индивидуальный',
          'Стюардесса',
          'Можно не печатать билет'
        ]
      }
    }
  end

  it 'fixtures load' do
    task.invoke(path)
    expect(Trip.last.to_h).to eq(expected_result)  
  end
end