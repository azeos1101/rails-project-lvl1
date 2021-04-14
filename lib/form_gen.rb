# frozen_string_literal: true

require 'form_gen/version'
require 'form_gen/tag'
require 'form_gen/form'

module FormGen
  class Error < StandardError; end

  def form_for(record, _attrs)
    form = Form.new(record: record)
    yield form
    form.to_s
  end
end
