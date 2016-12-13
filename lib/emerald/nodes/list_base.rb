#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Base rule for lists of images, metas, styles, and scripts
class ListBase < Node
  def to_html(context)
    output = ''
    elements[4].elements.each do |e|
      temp = ''
      e.elements[0].elements.each do |j|
        temp += " #{j.elements[0].text_value}='#{j.elements[2].to_html(context)}'"
      end

      case elements[0].text_value
      when 'images' then output += "<img #{temp}/>"
      when 'metas'  then output += "<meta #{temp}>"
      when 'styles' then output += "<link #{temp}/>"
      when 'scripts' then output += "<script #{temp}></script>"
      end
    end

    output
  end
end
