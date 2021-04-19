# frozen_string_literal: true

module HexletCode
  class Tag
    def self.build(tag_name, **attrs, &block)
      if block_given?
        render_paired(tag_name, attrs, &block)
      else
        render_self_closing(tag_name, attrs)
      end
    end

    def self.render_self_closing(name, attributes)
      "<#{stringify_open_tag(name, attributes)}>"
    end

    def self.render_paired(name, attributes)
      inner_html = yield
      "<#{stringify_open_tag(name, attributes)}>#{inner_html}</#{name}>"
    end

    def self.stringify_open_tag(name, attributes)
      attributes.map { |key, value| %(#{key}="#{value}") }
                .prepend(name)
                .compact
                .join(' ')
    end

    def self.render_select_option
      tag_attrs = attributes.map { |key, value| %(#{key}="#{value}") }
      value = values.first
      tag_attrs << "value=\"#{value}\""
      ["<#{name} #{tag_attrs.join(' ')}>", value, "</#{name}>"].join
    end
  end
end
