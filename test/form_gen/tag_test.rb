require "test_helper"

class FormGen::TagTest < Minitest::Test
  def test_generation_valid_self_closing_tag
    tag = FormGen::Tag.new(:input, type: 'text', value: 'some_string')

    assert_equal '<input type="text" value="some_string" />', tag.to_s
  end
end
