# frozen_string_literal: true

module HexletCode
  class Tag
    attr_reader :name, :attributes, :inner_html

    def initialize(tag_name, **attrs, &block)
      @name = tag_name
      @attributes = attrs
      @inner_html = yield(block) || '' if block_given?
    end

    def self.build(tag_name, **attrs, &block)
      Builder.build Tag.new(tag_name, **attrs, &block)
    end
  end
end
