require 'test_helper'

class BambooTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::VERSION
  end

  def test_if_correct_status_code
    client = Bamboo.new( ENV['BAMBOO_HOST'], ENV['BAMBOO_PORT'], ENV['BAMBOO_USERNAME'], ENV['BAMBOO_PASSWORD'])
    latest = client.latest.result(ENV['BAMBOO_PROJECT_CODE']).latest.get
    assert(latest.status == '200', "Received Status #{latest.status}, Expected Status: 200")
  end
end
