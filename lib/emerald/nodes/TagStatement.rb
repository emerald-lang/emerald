#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A tag
class TagStatement < Node
  def to_html(_context)
    "<#{elements[0].text_value}>#{elements[2].text_value}</#{elements[0].text_value}>"
  end

  def to_html_tag(context)
    if !elements[2].empty?
      "<#{elements[0].text_value} " +
        elements[2].to_html(context) +
        '>'
    else
      "<#{elements[0].text_value}>"
    end
  end
end
