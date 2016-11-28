#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# A long block of text literal, with variable templating
class TextLiteral < Node
  def to_html(context)
    body
      .elements
      .map do |element|
        if element.is_a?(Variable)
          element.to_html(context)
        else
          unescape element.text_value
        end
      end
      .join('')
      .rstrip
  end

  def unescape(text)
    text.gsub(/\\(.)/, '\1')
  end
end
