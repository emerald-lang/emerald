#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# A tag
class TagStatement < Node
  def to_html(context)
    opening_tag(context) +
      (
        if !body.empty?
          body.to_html(context)
        else
          ''
        end
      ) +
      closing_tag(context)
  end

  def opening_tag(context)
    "<#{elements[0].text_value}" +
      (
        if !elements[3].empty?
          elements[3].to_html(context)
        else
          ''
        end
      ) + '>'
  end

  def closing_tag(_context)
    "</#{elements[0].text_value}>"
  end
end
