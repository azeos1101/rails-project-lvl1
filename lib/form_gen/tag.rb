# frozen_string_literal: true

module FormGen
  class Tag
    # List of self closing elements
    # https://www.w3.org/TR/2011/WD-html-markup-20110113/syntax.html#syntax-elements
    SELF_CLOSING = %i[area base br col embed hr img input link meta param source track wbr].freeze

    attr_reader :name, :attributes
    attr_accessor :values

    def initialize(tag_name, **attrs)
      @name = tag_name
      @values = Array(attrs.delete(:value))
      @attributes = (attrs || {})
    end

    def to_s
      SELF_CLOSING.include?(name.to_sym) ? render_self_closing : render_closing
    end

    private

    def render_self_closing
      tag_attrs = attributes.map { |key, value| %(#{key}="#{value}") }
      tag_attrs << "value=\"#{values.first}\"" if values.first
      ["<#{name}", *tag_attrs, '/>'].compact.join(' ')
    end

    def render_closing
      string_values = values.map(&:to_s)
      tag_attrs = attributes.filter { |key, _v| key != :value }.map { |key, value| %(#{key}="#{value}") }.join(' ')
      ["<#{name} #{tag_attrs}>", *string_values, "</#{name}>"].join
    end
  end
end
