# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'

def normalize_html(str)
  str.gsub(/((^\s+)|(\s+$))/, '') # strip
     .gsub(/\ {2,}/, ' ') # remove multiply spaces
     .gsub(/\s</, '<') # remove whitespace before tag opening
end
