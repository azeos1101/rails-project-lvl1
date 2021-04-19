# frozen_string_literal: true

require 'test_helper'

module HexletCode
  class FormTest < Minitest::Test
    def test_generation_blank_form
      form = HexletCode::Form.new

      assert_equal '<form action="#" method="post"></form>', form.to_s
    end
  end
end
