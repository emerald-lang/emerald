#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'
require_relative 'Variable.rb'

# Element text content immediately following a tag name
class InlineLiteral < Node
  def to_html(context)
    elements
      .map do |element|
        if element.is_a?(Variable)
          element.to_html(context)
        else
          element.text_value
        end
      end
      .join('')
  end
end
