require 'test_helper'

class FormGenTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FormGen::VERSION
  end
end
