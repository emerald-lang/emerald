#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BaseScopeFn'

# Base class for scope functions
class Unless < BaseScopeFn
  def to_html(body, context)
    if boolean_expr.truthy?(context)
      ''
    else
      body.to_html(context)
    end
  end
end
