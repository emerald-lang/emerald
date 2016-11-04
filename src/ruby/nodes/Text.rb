#!/usr/bin/env ruby

require 'treetop'

class Text < Treetop::Runtime::SyntaxNode
  def to_html
    "<#{h_num.text_value}>" + 
      (
        elements[2].is_a?(MultilineLiteral) ?
        elements[2].to_html :
        elements[2].text_value
      ) +
      "</#{h_num.text_value}>"
  end
end
