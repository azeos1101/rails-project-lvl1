module FormGen
  class Tag
    SELF_CLOSING = %i[area base br col embed hr img input link meta param source track wbr]

    attr_reader :name, :attrs

    def initialize(tag_name, **attrs)
      @name = tag_name
      @attrs = (attrs || {})
    end

    def to_s
      SELF_CLOSING.include?(name.to_sym) ? render_self_closing : render_closing
    end

    private

    def render_self_closing
      attributes = attrs.map {|key, value| %Q[#{key}="#{value}"] }.join(' ')
      "<#{name} #{attributes} />"
    end

    def render_closing
      ''
    end
  end
end
