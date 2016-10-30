#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Root < Node
  def to_html
    elements.each do |e|
      e.to_html()
    end
  end
end
