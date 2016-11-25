#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# The attributes hash for an element
class Attributes < Node
  def to_html(_)
    # TODO: make this work
    elements
      .map(&:text_value)
      .join(' ')
  end
end
