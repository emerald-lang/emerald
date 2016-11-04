#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

# TODO: Refactor this
class List < Node
  def to_html
    if elements[0].text_value == "styles"
      elements[4].elements.map do |e|
        "<link rel='stylesheet' href=#{e.text_value.strip} />"
      end.join("\n")
    elsif elements[0].text_value == "scripts"
      elements[4].elements.map do |e|
        "<script type='text/javascript' src=#{e.text_value.strip}></script>"
      end.join("\n")
    elsif elements[0].text_value == "metas"
      elements[4].elements.map do |e|
        ""
      end.join("\n")
    end
  end
end
