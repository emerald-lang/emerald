#!/usr/bin/env ruby

require 'treetop'

class MultilineLiteral < Treetop::Runtime::SyntaxNode
  def to_html
    multiline_literal_body
      .text_value
      .gsub('\$', '$') # Unescape preprocessor escaping
      .rstrip
  end
end
