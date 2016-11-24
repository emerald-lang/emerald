#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# Base class for scope functions
class BaseScopeFn < Treetop::Runtime::SyntaxNode
  def to_html(_body, _context)
    raise 'not implemented :('
  end
end
