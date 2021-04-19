# frozen_string_literal: true

require 'test_helper'

module HexletCode
  class TagTest < Minitest::Test
    def test_generation_valid_self_closing_tag
      tag = HexletCode::Tag.build(:input, type: 'text', value: 'some_string')

      assert_equal '<input type="text" value="some_string">', tag
    end

    def test_generation_valid_closing_tag
      br = HexletCode::Tag.build(:br)
      span = HexletCode::Tag.build(:span, id: 'my_span') { 'some span text' }
      div = HexletCode::Tag.build(:div, class: 'col-xs-1') { [br, span].join }

      expected_html = '<div class="col-xs-1"><br><span id="my_span">some span text</span></div>'

      assert_equal expected_html, div
    end

    def test_tag_generations
      assert_equal '<br>', HexletCode::Tag.build('br')

      assert_equal '<img src="path/to/image">', HexletCode::Tag.build('img', src: 'path/to/image')
      assert_equal '<input type="submit" value="Save">', HexletCode::Tag.build('input', type: 'submit', value: 'Save')

      assert_equal '<label>Email</label>', HexletCode::Tag.build('label') { 'Email' }
      assert_equal '<label for="email">Email</label>', HexletCode::Tag.build('label', for: 'email') { 'Email' }
    end
  end
end
