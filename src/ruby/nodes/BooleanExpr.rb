#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# Variable interpolation in a template
class BooleanExpr < Treetop::Runtime::SyntaxNode
  def truthy?(context)
    elements.first.truthy?(context)
  end
end
