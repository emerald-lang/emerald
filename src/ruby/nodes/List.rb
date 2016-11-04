#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

# TODO: Refactor this
class List < Node
  def to_html(output)
    if elements[0].text_value == "styles"
      elements[4].elements.each do |e|
        output += "<link rel='stylesheet' href=#{e.text_value.strip} />"
      end
    elsif elements[0].text_value == "scripts"
      elements[4].elements.each do |e|
        output += "<script type='text/javascript' src=#{e.text_value.strip}></script>"
      end
    elsif elements[0].text_value == "metas"
      elements[4].elements.each do |e|
      end
    end
    output
  end
end
