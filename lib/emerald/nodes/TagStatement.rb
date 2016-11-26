#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A tag
class TagStatement < Node
  def to_html(context)
    if !elements[3].empty?
      "<#{elements[0].text_value}" + elements[3].to_html(context) + ">#{elements[2].text_value}"\
        "</#{elements[0].text_value}>"
    else
      "<#{elements[0].text_value}>#{elements[2].text_value}</#{elements[0].text_value}>"
    end
  end

  def to_html_tag(_context)
    "<#{elements[0].text_value}>"
  end
end
