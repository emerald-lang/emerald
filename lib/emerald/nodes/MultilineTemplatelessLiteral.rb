#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A long block of text literal, without variable templating
class MultilineTemplatelessLiteral < Node
  def to_html(context)
    body
      .text_value
      .gsub('\$', '$') # Unescape preprocessor escaping
      .rstrip
  end
end
