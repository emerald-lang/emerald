#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# The boolean condition for a logic statement
class BooleanExpr < Treetop::Runtime::SyntaxNode
  def truthy?(context)
    elements.first.truthy?(context)
  end
end
