# frozen_string_literal: true

require 'hexlet_code/version'
require 'hexlet_code/tag'
require 'hexlet_code/form'

module HexletCode
  def form_for(record, attrs)
    form = Form.new(record: record, **attrs)
    yield form if block_given?
    form.to_s
  end
end
