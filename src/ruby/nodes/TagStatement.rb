#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class TagStatement < Node
  def to_html
    "<#{elements[0].text_value}>#{elements[2].text_value}</#{elements[0].text_value}>"
  end

  def to_html_tag
    if !elements[2].empty?
      "<#{elements[0].text_value} #{elements[2].to_html("")}>"
    else
      "<#{elements[0].text_value}>"
    end
  end
end
