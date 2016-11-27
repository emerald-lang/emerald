#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# elements[2] is the attributes
# call to_html() on them.
class AttributeList < Node
  def to_html(context)
    elements[4].to_html(context)
  end
end
