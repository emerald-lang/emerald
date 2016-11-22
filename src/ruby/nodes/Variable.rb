#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# Variable interpolation in a template
class Variable < Node
  def to_html(context)
    variable_name
      .content(context)
      .to_s
  end
end
