# frozen_string_literal: true

module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Form, 'hexlet_code/form'
  autoload :Builder, 'hexlet_code/builder'
  autoload :VERSION, 'hexlet_code/version'

  def self.form_for(record, **attrs)
    raise NoFormBlock unless block_given?

    form = Form.new(record: record, **attrs)
    yield form

    Builder.build form
  end

  class NoFormBlock < StandardError; end
end
