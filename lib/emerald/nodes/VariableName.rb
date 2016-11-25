#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BooleanExpr'

# Variable interpolation in a template
class VariableName < BooleanExpr
  def content(context)
    text_value
      .split('.')
      .reduce(context) do |ctx, name|
        ctx[name] || ctx[name.to_sym] || nil
      end
  end

  def truthy?(context)
    !!content(context)
  end
end
