#!/usr/bin/env ruby

require 'treetop'

class Node < Treetop::Runtime::SyntaxNode
  def to_html
    puts "default to_html"
  end
end
