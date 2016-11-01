#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Line < Node
  def to_html(output)
    e = elements[0]

    if e.is_a?(TagStatement) || e.is_a?(Text)
      output += "<#{e.elements[0].text_value}>#{e.elements[2].text_value}</#{e.elements[0].text_value}>"
    end
    output
  end
end
