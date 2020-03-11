require 'test_helper'
require 'json'

class TestIndex < ActiveSupport::TestCase
  def test_index_content
    file_name = "tmp\#{Time.now.to_i}.html"
    system "wget http://localhost:3000/%D0%B0%D0%B2%D1%82%D0%BE%D0%B1%D1%83%D1%81%D1%8B/%D0%A1%D0%B0%D0%BC%D0%B0%D1%80%D0%B0/%D0%9C%D0%BE%D1%81%D0%BA%D0%B2%D0%B0 -q -O #{file_name}"
    diff_result = ` diff fixtures/sample.html #{file_name} -d`
    assert(diff_result[0..3] == "6c6\n")
  end
end