#!/usr/bin/env ruby

require 'treetop'

class Test < Node
  def to_html
    elements.each do |e|
      e.to_html()
    end
  end
end
