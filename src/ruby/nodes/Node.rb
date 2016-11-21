#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'

# TODO: what is this
# tbh I'm not sure
class Node < Treetop::Runtime::SyntaxNode
  def to_html(_context)
    raise 'not implemented :('
  end
end
