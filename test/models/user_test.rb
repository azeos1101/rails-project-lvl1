# frozen_string_literal: true

require 'active_model'

class UserTest < OpenStruct
  extend ActiveModel::Naming

  def id
    '12345'
  end

  def type_for_attribute(attr_name)
    case attr_name.to_sym
    when :id
      :hidden
    else
      :text
    end
  end
end
