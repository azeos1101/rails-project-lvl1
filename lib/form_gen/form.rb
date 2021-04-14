# frozen_string_literal: true

# require ''

module FormGen
  class Form
    attr_reader :tag, :attributes, :record

    def initialize(**attrs)
      @record = attrs.delete(:record)
      @attributes = attributes_with_defaults(attrs)
      @tag = Tag.new(:form, **attributes)
    end

    def to_s
      tag.to_s
    end

    def input(attr_name, **attrs)
      return unless record.respond_to? :model_name

      model_name = record.model_name.singular
      new_attrs = attrs.merge(type: record.type_for_attribute(attr_name))
      new_tag = Tag.new(:input,
                        name: "#{model_name}[#{attr_name}]",
                        id: "#{model_name}_#{attr_name}",
                        **new_attrs)
      tag.values << new_tag
    end

    def hidden_input(attr_name, **attrs)
      new_attrs = attrs.merge(type: 'hidden')
      input(attr_name, **new_attrs)
    end

    private

    def attributes_with_defaults(attrs)
      form_attrs = attrs || {}
      default_values = { action: '#', method: 'post' }

      default_values.merge(**form_attrs)
    end
  end
end
