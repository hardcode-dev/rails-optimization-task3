require 'test_helper'
require 'json'

class TestLoad < ActiveSupport::TestCase
  def test_correct_load
    source_json = JSON.load(File.read('fixtures/example.json'))
    system 'bin/rake reload_json[fixtures/example.json]'
    result_json = Trip.all.order(:id).map(&:to_h_old)
    assert_equal source_json, result_json
  end

  def test_perfomance_load
    total = Benchmark.measure{ system 'bin/rake reload_json[fixtures/medium.json]'}.total
    assert(total < 8)
  end
end