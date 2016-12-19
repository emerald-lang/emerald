#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'boolean_expr'

# Variable interpolation in a template
class VariableName < BooleanExpr
  def content(context)
    text_value
      .split('.')
      .reduce(context) do |ctx, name|
        next nil if ctx.nil?
        ctx[name] || ctx[name.to_sym] || nil
      end
  end

  def truthy?(context)
    !!content(context)
  end
end
