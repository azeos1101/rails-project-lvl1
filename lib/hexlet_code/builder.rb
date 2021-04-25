# frozen_string_literal: true

module HexletCode
  class Builder
    def self.build(tag)
      tag.inner_html.nil? ? build_self_closing(tag) : build_paired(tag)
    end

    def self.build_self_closing(tag)
      "<#{stringify_open_tag(tag.name, tag.attributes)}>"
    end

    def self.build_paired(tag)
      inner_html = stringify_inner_html(tag)
      "<#{stringify_open_tag(tag.name, tag.attributes)}>#{inner_html}</#{tag.name}>"
    end

    def self.stringify_open_tag(tag_name, attributes)
      attributes.map { |key, value| %(#{key}="#{value}") }
                .prepend(tag_name)
                .compact
                .join(' ')
    end

    def self.stringify_inner_html(tag)
      inner_html_parts = Array(tag.inner_html)
      inner_html_parts.map { |part| part.is_a?(::HexletCode::Tag) ? build(part) : part.to_s }
                      .join
    end
  end
end
