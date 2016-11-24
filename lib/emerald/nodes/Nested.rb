#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

#
# Appends compiled html for nested rule to the output.
# elements[0] is the tag statement, elements[4] is any nested html.
#
class Nested < Node
  def to_html(context)
    elements[0].to_html_tag(context) +
      elements[4].to_html(context) +
      "</#{elements[0].elements[0].text_value}>"
  end
end
