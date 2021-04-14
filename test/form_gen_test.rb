# frozen_string_literal: true

require 'test_helper'

class FormGenTest < Minitest::Test
  include FormGen

  def setup
    super
    @expected_html = '<form action="/users/new" method="post">'\
                        '<input name="user_test[id]" id="user_test_id" type="hidden" value="12345" />'\
                        '<input name="user_test[name]" id="user_test_name" type="text" value="Vasya" />'\
                        '<textarea cols="20" rows="40" name="user_test[description]" id="user_test_description">'\
                          'Hexlet Form'\
                        '</textarea>'\
                      '</form>'
  end

  def test_that_it_has_a_version_number
    refute_nil ::FormGen::VERSION
  end

  def test_form_generation
    user = UserTest.new(name: 'Vasya', description: 'Hexlet Form')

    result_form = form_for user, url: '/users/new' do |f|
      f.input :id
      f.input :name
      f.input :description, as: :text
    end

    assert_equal @expected_html, result_form
  end
end
