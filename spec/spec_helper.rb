# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'emerald'

def whitespace_agnostic(str)
  str.gsub(/\s+/, ' ').strip
end

def convert(context:, input:, preserve_whitespace: false)
  output = Emerald.convert(input, context)
  unless preserve_whitespace
    whitespace_agnostic output
  else
    output
  end
end

def preprocess(input, preserve_whitespace: false)
  output, _ = Emerald::PreProcessor.new.process_emerald(input)
  unless preserve_whitespace
    whitespace_agnostic output
  else
    output
  end
end

def source_map(input)
  _, map = Emerald::PreProcessor.new.process_emerald(input)
  map
end
