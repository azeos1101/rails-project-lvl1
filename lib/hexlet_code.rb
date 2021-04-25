# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag.rb'
  autoload :Form, 'hexlet_code/form.rb'
  autoload :VERSION, 'hexlet_code/version.rb'

  def self.form_for(record, **attrs)
    form = Form.new(record: record, **attrs)
    yield form if block_given?
    form.to_s
  end
end
