# frozen_string_literal: true

require 'active_support'

module HexletCode
  class Form
    attr_reader :name, :attributes, :record
    attr_accessor :inner_html

    def initialize(**attrs)
      @record = attrs[:record]
      @name = :form
      @attributes = attributes_with_defaults(attrs.except(:record))
      @inner_html = []
    end

    def submit
      inner_html << submit_tag
    end

    def input(attr_name, **attrs)
      inner_html << label_tag(attr_name)
      inner_html << input_tag(attr_name, **attrs)
    end

    private

    def label_tag(attr_name)
      Tag.new(:label, for: attr_name) { attr_name.to_s.capitalize.gsub('_', ' ') }
    end

    def submit_tag
      Tag.new(:input, type: 'submit', value: 'Save', name: 'commit')
    end

    def input_tag(attr_name, **attrs)
      input_type = attrs.delete(:as)
      return Tag.new(:textarea, name: attr_name, id: attr_name) { record[attr_name] } if input_type == :text

      new_attrs = attrs.merge(type: 'text', value: record[attr_name], name: attr_name, id: attr_name)
      Tag.new(:input, **new_attrs)
    end

    def attributes_with_defaults(attrs)
      form_attrs = attrs || {}
      form_attrs[:action] = form_attrs.delete(:url) || '#'
      form_attrs[:method] ||= 'post'

      form_attrs
    end
  end
end
