#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Nested < Node
  def to_html(output)
    output += elements[0].to_html(output)
    output += elements[4].to_html(output)
    output += "</#{elements[0].elements[0].text_value}>"

    output
  end
end
