#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

# Prints out the value of the comment's text
class Comment < Node
  def to_html
    puts "<!-- #{elements[2].text_value} -->"
  end
end
