#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# Prints out the value of the comment's text
class Comment < Node
  def to_html(_context)
    "<!-- #{elements[2].text_value} -->"
  end
end
