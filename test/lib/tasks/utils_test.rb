# frozen_string_literal: true

require 'test_helper'
require 'rake'

class UtilsTest < ActiveSupport::TestCase
  def setup
    Rails.application.load_tasks if Rake::Task.tasks.empty?
    @path = 'test/fixtures/files/data.json'
    @expected_result = {
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

  test 'fixtures load' do

    Rake::Task['utils:reload_json'].invoke(@path)

    assert_equal Trip.last.to_h, @expected_result
  end
end