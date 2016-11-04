#!/usr/bin/env ruby

require 'treetop'
require_relative 'Node'

class Root < Node
  def to_html
    elements
      .map{|e| e.to_html}
      .join("\n")
  end
end
