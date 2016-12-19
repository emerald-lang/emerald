#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Special rule for lists of images, styles, and scripts
class ValueList < Node
  def to_html(context)
    list_items.elements.map do |e|
      case keyword.text_value
      when 'images'  then "<img src=\"#{e.literal.to_html(context)}\"/>"
      when 'styles'  then "<link rel=\"stylesheet\" href=\"#{e.literal.to_html(context)}\"/>"
      when 'scripts' then "<script type=\"text/javascript\" src=\"#{e.literal.to_html(context)}\"></script>"
      end
    end.join("\n")
  end
end
