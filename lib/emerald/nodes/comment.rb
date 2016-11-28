#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Prints out the value of the comment's text
class Comment < Node
  def to_html(context)
    "<!-- #{text_content.to_html(context)} -->\n"
  end
end
