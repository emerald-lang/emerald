#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'base_scope_fn'

# Renders if a condition is met
class Given < BaseScopeFn
  def to_html(body, context)
    if boolean_expr.truthy?(context)
      body.to_html(context)
    else
      ''
    end
  end
end
