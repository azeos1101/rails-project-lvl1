# frozen_string_literal: true

module HexletCode
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
      return render_select_option if name == :option
      return render_self_closing if SELF_CLOSING.include?(name.to_sym)

      render_closing
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

    def render_select_option
      tag_attrs = attributes.map { |key, value| %(#{key}="#{value}") }
      value = values.first
      tag_attrs << "value=\"#{value}\""
      ["<#{name} #{tag_attrs.join(' ')}>", value, "</#{name}>"].join
    end
  end
end
