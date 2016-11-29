#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'node'

# Block that modifies the context
class Scope < Node
  def to_html(context)
    fn.to_html(body, context)
  end
end
