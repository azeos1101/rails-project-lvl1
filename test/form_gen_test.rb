# frozen_string_literal: true

require 'test_helper'

class FormGenTest < Minitest::Test
  include FormGen

  def setup
    super
    @user = UserTest.new(name: 'Vasya', description: 'Hexlet Form')
  end

  def test_that_it_has_a_version_number
    refute_nil ::FormGen::VERSION
  end

  def test_blank_form_generation
    expected_html = '<form action="/users/new" method="post"></form>'
    result_form = form_for @user, url: '/users/new'

    assert_equal expected_html, result_form
  end

  def test_form_with_input
    expected_html = '<form action="/users/new" method="post">'\
                      '<input name="user_test[name]" id="user_test_name" type="text" value="Vasya" />'\
                    '</form>'
    result_form = form_for @user, url: '/users/new' do |f|
      f.input :name
    end

    assert_equal expected_html, result_form
  end

  def test_form_with_hidden_input
    expected_html = '<form action="/users/new" method="post">'\
                      '<input name="user_test[id]" id="user_test_id" type="hidden" value="12345" />'\
                      '<input name="user_test[name]" id="user_test_name" type="text" value="Vasya" />'\
                    '</form>'
    result_form = form_for @user, url: '/users/new' do |f|
      f.input :id
      f.input :name
    end

    assert_equal expected_html, result_form
  end

  def test_form_with_textarea # rubocop:disable Metrics/MethodLength
    expected_html = '<form action="/users/new" method="post">'\
                      '<input name="user_test[name]" id="user_test_name" type="text" value="Vasya" />'\
                          '<textarea cols="20" rows="40" name="user_test[description]" id="user_test_description">'\
                        'Hexlet Form'\
                      '</textarea>'\
                    '</form>'

    result_form = form_for @user, url: '/users/new' do |f|
      f.input :name
      f.input :description, as: :text
    end

    assert_equal expected_html, result_form
  end

  def test_form_with_select # rubocop:disable Metrics/MethodLength
    expected_html = '<form action="#" method="post">'\
                      '<input name="user_test[name]" id="user_test_name" type="text" value="Vasya" />'\
                      '<select name="user_test[age]" id="user_test_age">'\
                        '<option value=""></option>'\
                        '<option value="18">18</option>'\
                        '<option value="19">19</option>'\
                        '<option value="20">20</option>'\
                      '</select>'\
                    '</form>'

    result_form = form_for @user, url: '#' do |f|
      f.input :name
      f.input :age, as: :select, collection: 18..20
    end

    assert_equal expected_html, result_form
  end
end
