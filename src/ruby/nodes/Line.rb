#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Line < Node
  def to_html
    e = elements[0]

    if e.is_a?(TagStatement) || e.is_a?(Text)
      e.to_html
    else
      raise "well you shouldn't be here :("
    end
  end
end
