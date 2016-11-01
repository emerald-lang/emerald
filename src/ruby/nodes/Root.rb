#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Root < Node
  def to_html(output)
    elements.each do |e|
      output += e.to_html("")
    end
    output
  end
end
