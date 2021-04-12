require "test_helper"

class FormGen::TagTest < Minitest::Test
  def test_generation_valid_self_closing_tag
    tag = FormGen::Tag.new(:input, type: 'text', value: 'some_string')

    assert_equal '<input type="text" value="some_string" />', tag.to_s
  end

  def test_generation_valid_closing_tag
    br = FormGen::Tag.new(:br)
    span = FormGen::Tag.new(:span, value: 'some span text', id: 'my_span')
    div = FormGen::Tag.new(:div, class: 'col-xs-1', value: [br, span])
    expected_html = '<div class="col-xs-1"><br /><span id="my_span">some span text</span></div>'

    assert_equal expected_html, div.to_s
  end
end
