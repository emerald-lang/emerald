#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A long block of text literal, without variable templating
class MultilineLiteral < Node
  def to_html(_context)
    multiline_literal_body
      .text_value
      .gsub('\$', '$') # Unescape preprocessor escaping
      .rstrip
  end
end
