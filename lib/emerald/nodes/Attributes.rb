#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# The attributes hash for an element
class Attributes < Node
  def to_html(context)
    output = ''
    elements.each do |e|
      output += " #{e.elements[0].text_value}=\"#{e.elements[2].to_html(context)}\""
    end
    output
  end
end
