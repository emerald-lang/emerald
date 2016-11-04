#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class TagStatement < Node
  def to_html

    return "<#{elements[0].text_value}>#{elements[2].text_value}</#{elements[0].text_value}>"

    # todo: make this work
    if elements[4].is_a?(AttributeList)
      output += ("<#{elements[0].text_value}#{elements[4].to_html()}>" +
                 "#{elements[2].text_value.delete! '(),'}")
    elsif !elements[2].empty?
      output += "<#{elements[0].text_value} #{elements[2].to_html("")}>"
    else
      output += "<#{elements[0].text_value}>"
    end
  end
end
