require 'test_helper'

class BambooTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::VERSION
  end

  def test_if_correct_status_code
    client = Bamboo.new("bamboo.host.com", "8085", ENV['BAMBOO_USERNAME'], ENV['BAMBOO_PASSWORD'])
    status, body = client.latest.result("PROECT_CODE").latest.get
    assert(status == '200', "Received Status #{status}, Expected Status: 200")
  end
end
