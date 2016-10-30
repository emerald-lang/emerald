#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Nested < Node
  def to_html
    elements[0].to_html()
    elements[4].to_html()
    puts "</#{elements[0].elements[0].text_value}>"
  end
end
