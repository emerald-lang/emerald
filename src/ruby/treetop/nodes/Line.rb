#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Line < Node
  def to_html
    e = elements[0]

    if e.is_a?(TagStatement) || e.is_a?(Text)
      puts "<#{e.elements[0].text_value}>#{e.elements[2].text_value}</#{e.elements[0].text_value}>"
    end
  end
end
