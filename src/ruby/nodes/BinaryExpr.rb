#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BooleanExpr'

# Variable interpolation in a template
class BinaryExpr < BooleanExpr
  def truthy?(context)
    case op.text_value
    when 'and'
      lhs.truthy?(context) && rhs.truthy?(context)
    when 'or'
      lhs.truthy?(context) || rhs.truthy?(context)
    end
  end
end
