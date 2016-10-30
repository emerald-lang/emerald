#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class List < Node
  def to_html
    if elements[0].text_value == "styles"
      elements[4].elements.each do |e|
        puts "<link rel='stylesheet' href=#{e.text_value.strip} />"
      end
    end
  end
end
