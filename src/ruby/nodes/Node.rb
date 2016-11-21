#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# Base class for all Emerald syntax nodes
class Node < Treetop::Runtime::SyntaxNode
  def to_html(_context)
    raise 'not implemented :('
  end
end
