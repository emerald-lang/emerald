#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# A heading tag
class Text < Treetop::Runtime::SyntaxNode
  def to_html(context)
    "<#{h_num.text_value}>" +
      (
        if body.text_value.length.nonzero?
          body.to_html(context)
        else
          ''
        end
      ) +
      "</#{h_num.text_value}>"
  end
end
