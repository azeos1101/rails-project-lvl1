# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :attributes, :record
    attr_accessor :inner_tags

    def initialize(**attrs)
      @record = attrs[:record]
      @attributes = attributes_with_defaults(attrs.except(:record))
      @inner_tags = []
    end

    def to_s
      Tag.build(:form, **attributes) { inner_tags.join }
    end

    def submit
      inner_tags << Tag.build(:input, type: 'submit', value: 'Save', name: 'commit')
    end

    def input(attr_name, **attrs)
      input_type = attrs.delete(:as)
      label = Tag.build(:label, for: attr_name) { attr_name.to_s.capitalize.gsub('_', ' ') }
      input_tag = if input_type == :text
                    Tag.build(:textarea, name: attr_name, id: attr_name) { record[attr_name] }
                  else
                    new_attrs = attrs.merge(type: 'text', value: record[attr_name], name: attr_name, id: attr_name)
                    Tag.build(:input, **new_attrs)
                  end
      inner_tags << label
      inner_tags << input_tag
    end

    private

    def attributes_with_defaults(attrs)
      form_attrs = attrs || {}
      form_attrs[:action] = form_attrs.delete(:url) || '#'
      form_attrs[:method] ||= 'post'

      form_attrs
    end
  end
end
