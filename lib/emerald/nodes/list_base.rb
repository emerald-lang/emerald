#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Base rule for lists of images, metas, styles, and scripts
class ListBase < Node
  def to_html(context)
    elements[4].elements.map do |e|
      attrs = e.elements[0].elements.map do |j|
        "#{j.elements[0].text_value}='#{j.elements[2].to_html(context)}'"
      end.join(' ')

      case elements[0].text_value
      when 'images'  then "<img #{attrs}/>"
      when 'metas'   then "<meta #{attrs}>"
      when 'styles'  then "<link #{attrs}/>"
      when 'scripts' then "<script #{attrs}></script>"
      end
    end.join("\n")
  end
end
