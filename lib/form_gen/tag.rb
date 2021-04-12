module FormGen
  class Tag
    SELF_CLOSING = %i[area base br col embed hr img input link meta param source track wbr]

    attr_reader :name, :attributes

    def initialize(tag_name, **attrs)
      @name = tag_name
      @attributes = (attrs || {})
    end

    def to_s
      SELF_CLOSING.include?(name.to_sym) ? render_self_closing : render_closing
    end

    private

    def render_self_closing
      tag_attrs = attributes.map { |key, value| %(#{key}="#{value}") }
      ["<#{name}", *tag_attrs, '/>'].compact.join(' ')
    end

    def render_closing
      values = Array(attributes[:value]).compact.map(&:to_s)
      tag_attrs = attributes.filter { |key, _v| key != :value }.map { |key, value| %(#{key}="#{value}") }.join(' ')
      ["<#{name} #{tag_attrs}>", *values, "</#{name}>"].join
    end
  end
end
