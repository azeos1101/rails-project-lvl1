# require ''

module FormGen
  class Form
    attr_reader :tag, :attributes

    def initialize(**attrs)
      @attributes = attributes_with_defaults(attrs)

      @tag = Tag.new(:form, **attributes)
    end

    def to_s
      tag.to_s
    end

    private

    def attributes_with_defaults(attrs)
      form_attrs = attrs || {}
      default_values = { action: '#', method: 'post' }

      default_values.merge **form_attrs
    end
  end
end
