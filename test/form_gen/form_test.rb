require 'test_helper'

class FormGen::FormTest < Minitest::Test
  def test_generation_blank_form
    form = FormGen::Form.new

    assert_equal '<form action="#" method="post"></form>', form.to_s
  end
end
