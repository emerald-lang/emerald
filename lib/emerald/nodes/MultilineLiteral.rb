#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A long block of text literal, with variable templating
class MultilineLiteral < Node
  def to_html(context)
    body
      .elements
      .map do |element|
        if element.is_a?(Variable)
          element.to_html(context)
        else
          element.text_value
        end
      end
      .join('')
      .gsub('\$', '$') # Unescape preprocessor escaping
      .rstrip
  end
end
