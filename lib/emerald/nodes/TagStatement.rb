#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# A tag
class TagStatement < Node
  def to_html(context)
    "<#{elements[0].text_value}" +
      (
        if !elements[3].empty?
          elements[3].to_html(context)
        else
          ''
        end
      ) + '>' +
      (
        if !body.empty?
          body.to_html(context)
        else
          ''
        end
      ) +
      "</#{elements[0].text_value}>"
  end

  def to_html_tag(_context)
    "<#{elements[0].text_value}>"
  end
end
