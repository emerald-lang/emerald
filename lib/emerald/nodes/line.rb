#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# Either a tag or text
class Line < Node
  def to_html(context)
    e = elements[0]

    e.to_html(context)
  end
end
