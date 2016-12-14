#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Base rule for lists of images, metas, styles, and scripts
class PairList < Node
  def to_html(context)
    list_items.elements.map do |e|
      attrs = e.pairs.elements.map do |j|
        "#{j.attr.text_value}=\"#{j.literal.to_html(context)}\""
      end.join(' ')

      case keyword.text_value
      when 'images'  then "<img #{attrs}/>"
      when 'metas'   then "<meta #{attrs}>"
      when 'styles'  then "<link #{attrs}/>"
      when 'scripts' then "<script #{attrs}></script>"
      end
    end.join("\n")
  end
end
