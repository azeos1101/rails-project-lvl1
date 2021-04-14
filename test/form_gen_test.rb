# frozen_string_literal: true

require 'active_model'
require 'test_helper'

class User
  extend ActiveModel::Naming

  def type_for_attribute(attr_name)
    case attr_name.to_sym
    when :id
      :hidden
    else
      :text
    end
  end
end

class FormGenTest < Minitest::Test
  include FormGen

  def test_that_it_has_a_version_number
    refute_nil ::FormGen::VERSION
  end

  def test_form_generation
    user = User.new
    expected_html = '<form action="#" method="post">'\
                    '<input name="user[name]" id="user_name" type="text" />'\
                    '<input name="user[id]" id="user_id" type="hidden" />'\
                    '</form>'

    result_form = form_for user, url: '/users/new' do |f|
      f.input :name
      f.input :id
    end

    assert_equal expected_html, result_form
  end
end
