# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_blank_hexlet_codegeration
    user = User.new(name: 'Vasya', job: 'Dev')

    expected_html = '<form action="#" method="post"></form>'
    # rubocop:disable Lint/EmptyBlock
    result_form = HexletCode.form_for user do |f|
    end
    # rubocop:enable Lint/EmptyBlock

    assert_equal expected_html, result_form
  end

  def test_form_with_input
    user = User.new(name: 'rob')
    expected_html = '<form action="#" method="post">' \
                      '<input type="text" value="rob" name="name">' \
                      '<input type="text" value="" name="job">' \
                    '</form>'
    result_form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
    end

    assert_equal expected_html, result_form
  end
end
