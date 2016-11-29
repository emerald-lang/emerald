#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'boolean_expr'

# A boolean expression with one child
class UnaryExpr < BooleanExpr
  def truthy?(context)
    if negated.text_value.length.positive?
      !elements[1].val.truthy?(context)
    else
      elements[1].val.truthy?(context)
    end
  end
end
