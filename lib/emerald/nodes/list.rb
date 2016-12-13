#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Special rule for lists of images, styles, and scripts
class ListSpecial < Node
  def to_html(_context)
    elements[4].elements.map do |e|
      case elements[0].text_value
      when 'images'  then "<img src=#{e.text_value.strip}/>"
      when 'styles'  then "<link rel='stylesheet' href=#{e.text_value.strip}/>"
      when 'scripts' then "<script type='text/javascript' src=#{e.text_value.strip}></script>"
      end
    end.join("\n")
  end
end
