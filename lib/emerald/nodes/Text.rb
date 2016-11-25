#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# A heading tag
class Text < Treetop::Runtime::SyntaxNode
  def to_html(context)
    "<#{h_num.text_value}>" +
      (
        case elements[2]
        when MultilineLiteral, InlineLiteral
          elements[2].to_html(context)
        else
          elements[2].text_value
        end
      ) +
      "</#{h_num.text_value}>"
  end
end
