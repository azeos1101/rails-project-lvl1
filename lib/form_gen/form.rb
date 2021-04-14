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

      tag.values << tag_builder(attr_name, attrs).call
    end

    def hidden_input(attr_name, **attrs)
      new_attrs = attrs.merge(type: 'hidden')
      input(attr_name, **new_attrs)
    end

    private

    def tag_builder(attr_name, attrs)
      tag_type = attrs.delete(:as)
      new_attrs = extract_attrs(attr_name, attrs)

      case tag_type&.to_sym
      when :text
        -> { Tag.new(:textarea, cols: '20', rows: '40', **new_attrs) }
      when :select
        select_builder(new_attrs)
      else
        new_attrs[:type] = record.type_for_attribute(attr_name)
        -> { Tag.new(:input, **new_attrs) }
      end
    end

    def select_builder(new_attrs)
      collection = [nil, *(new_attrs.delete(:collection) || [])] # with blank first value
      new_attrs[:value] = collection.map { |value| Tag.new(:option, value: value) }

      -> { Tag.new(:select, **new_attrs) }
    end

    def extract_attrs(attr_name, attrs)
      model_name = record.model_name.singular
      attrs.merge(name: "#{model_name}[#{attr_name}]",
                  id: "#{model_name}_#{attr_name}",
                  value: record.public_send(attr_name))
    end

    def attributes_with_defaults(attrs)
      form_attrs = attrs || {}
      form_attrs[:action] = form_attrs.delete(:url) || '#'
      form_attrs[:method] ||= 'post'

      form_attrs
    end
  end
end
