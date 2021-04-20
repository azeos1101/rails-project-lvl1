# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)

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
    result_form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job
    end

    assert_equal expected_form_html, result_form
  end

  private

  def expected_form_html
    <<~HTML.strip.gsub(/(^\s+)|(\n)/, '')
      <form action="#" method="post">
        <label for="name">Name</label>
        <input type="text" value="rob" name="name" id="name">
        <label for="job">Job</label>
        <input type="text" value="" name="job" id="job">
      </form>
    HTML
  end
end
