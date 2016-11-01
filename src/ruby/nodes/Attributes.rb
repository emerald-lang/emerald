#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Attributes < Node
  def to_html(output)
    elements.each do |e|
      output += e.text_value
    end
    output
  end
end
