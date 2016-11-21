#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'Node'

# Variable interpolation in a template
class Variable < Node
  def to_html(context)
    variable_name
      .text_value
      .split('.')
      .reduce(context) do |ctx, name|
        ctx[name] || ctx[name.to_sym] || nil
      end
  end
end
