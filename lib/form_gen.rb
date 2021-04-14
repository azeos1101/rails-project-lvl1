# frozen_string_literal: true

require 'form_gen/version'
require 'form_gen/tag'
require 'form_gen/form'

module FormGen
  class Error < StandardError; end

  def form_for(record, attrs)
    form = Form.new(record: record, **attrs)
    yield form if block_given?
    form.to_s
  end
end
