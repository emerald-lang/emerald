#!/usr/bin/env ruby
# frozen_string_literal: true

require 'treetop'
require_relative 'BaseScopeFn'

# Base class for scope functions
class Given < BaseScopeFn
  def to_html(body, context)
    if boolean_expr.truthy?(context)
      body.to_html(context)
    else
      ''
    end
  end
end
