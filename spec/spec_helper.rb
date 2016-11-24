# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'emerald'

def whitespace_agnostic(str)
  str.gsub(/\s+/, ' ').strip
end

def convert(context:, input:)
  whitespace_agnostic Emerald.convert(input, context)
end
