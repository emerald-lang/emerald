#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# A heading tag
class Text < Node
  def to_html(context)
    "<#{h_num.text_value}" +
      (
        case elements[3].empty?
        when false
          elements[3].to_html(context)
        else
          ''
        end
      ) + '>' +
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
